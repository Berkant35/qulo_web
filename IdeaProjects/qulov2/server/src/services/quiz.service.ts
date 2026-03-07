import { supabase } from "../config/supabase.js";
import { Errors } from "../utils/errors.js";
import { calculatePowerCost, calculateGreenReward, shuffleArray } from "../utils/math.js";
import { diamondService } from "./diamond.service.js";
import { NotificationService } from "./notification.service.js";
import type { PowerName } from "../types/index.js";

interface SessionRow {
  id: string;
  solver_id: string;
  target_id: string;
  status: string;
  current_q: number;
  total_questions: number;
  expires_at: string;
  completed_at: string | null;
}

interface QuestionRow {
  id: string;
  user_id: string;
  order_num: number;
  question_text: string;
  correct_answer: number;
  answer_1: string;
  answer_2: string;
  answer_3: string;
  answer_4: string;
  hint_text: string | null;
  stats_correct: number;
  stats_wrong: number;
}

interface PowerRow {
  id: string;
  name: string;
  base_cost: number;
  is_active: boolean;
}

export class QuizService {
  // ─── Start Session ─────────────────────────────────────────────
  async startSession(solverId: string, targetId: string) {
    // 1. Check target has >= 2 questions
    const { count: qCount, error: qErr } = await supabase
      .from("questions")
      .select("id", { count: "exact", head: true })
      .eq("user_id", targetId);

    if (qErr) throw Errors.SERVER_ERROR();
    const totalQuestions = qCount ?? 0;
    if (totalQuestions < 2) throw Errors.NO_QUESTIONS();

    // 2. Check no active IN_PROGRESS session for this solver+target pair
    const { data: existing, error: existErr } = await supabase
      .from("quiz_sessions")
      .select("id")
      .eq("solver_id", solverId)
      .eq("target_id", targetId)
      .eq("status", "IN_PROGRESS")
      .maybeSingle();

    if (existErr) throw Errors.SERVER_ERROR();

    if (existing) {
      return { session_id: existing.id as string, total_questions: totalQuestions };
    }

    // 3. Create session
    const expiresAt = new Date(Date.now() + totalQuestions * 30 * 1000).toISOString();

    const { data: session, error: createErr } = await supabase
      .from("quiz_sessions")
      .insert({
        solver_id: solverId,
        target_id: targetId,
        status: "IN_PROGRESS",
        current_q: 1,
        total_questions: totalQuestions,
        expires_at: expiresAt,
      })
      .select("id")
      .single();

    if (createErr || !session) throw Errors.SERVER_ERROR();

    // 4. Notify target
    await NotificationService.sendPush(targetId, "quiz_started");

    return { session_id: session.id as string, total_questions: totalQuestions };
  }

  // ─── Get Current Question ──────────────────────────────────────
  async getCurrentQuestion(sessionId: string, solverId: string) {
    const session = await this.getActiveSession(sessionId, solverId);

    // Get target's questions ordered by order_num
    const { data: questions, error: qErr } = await supabase
      .from("questions")
      .select("id, order_num, question_text, answer_1, answer_2, answer_3, answer_4, hint_text")
      .eq("user_id", session.target_id)
      .order("order_num", { ascending: true });

    if (qErr || !questions || questions.length === 0) throw Errors.SERVER_ERROR();

    // Get current question (index = current_q - 1)
    const questionIndex = session.current_q - 1;
    if (questionIndex >= questions.length) throw Errors.SERVER_ERROR();

    const q = questions[questionIndex];

    // Build answers and shuffle
    const answers = [
      { index: 1, text: q.answer_1 as string },
      { index: 2, text: q.answer_2 as string },
      { index: 3, text: q.answer_3 as string },
      { index: 4, text: q.answer_4 as string },
    ];
    const shuffledAnswers = shuffleArray(answers);

    return {
      session_id: sessionId,
      question_number: session.current_q,
      total_questions: session.total_questions,
      question_id: q.id as string,
      question_text: q.question_text as string,
      answers: shuffledAnswers,
      has_hint: q.hint_text != null && (q.hint_text as string).length > 0,
      time_limit_seconds: 30,
    };
  }

  // ─── Answer Question ──────────────────────────────────────────
  async answerQuestion(
    sessionId: string,
    solverId: string,
    selectedAnswer: number,
    powerUsed?: PowerName,
  ) {
    const session = await this.getActiveSession(sessionId, solverId);

    // Get current question WITH correct_answer
    const { data: questions, error: qErr } = await supabase
      .from("questions")
      .select("id, order_num, question_text, correct_answer, answer_1, answer_2, answer_3, answer_4, hint_text, stats_correct, stats_wrong")
      .eq("user_id", session.target_id)
      .order("order_num", { ascending: true });

    if (qErr || !questions || questions.length === 0) throw Errors.SERVER_ERROR();

    const questionIndex = session.current_q - 1;
    const currentQuestion = questions[questionIndex] as unknown as QuestionRow;

    // Check not already answered for this question
    const { data: existingAnswer, error: ansErr } = await supabase
      .from("quiz_answers")
      .select("id")
      .eq("session_id", sessionId)
      .eq("question_id", currentQuestion.id)
      .maybeSingle();

    if (ansErr) throw Errors.SERVER_ERROR();
    if (existingAnswer) throw Errors.ALREADY_ANSWERED();

    // ─── Power handling ───
    if (powerUsed) {
      // Get power from powers table
      const { data: power, error: powerErr } = await supabase
        .from("powers")
        .select("id, name, base_cost, is_active")
        .eq("name", powerUsed)
        .eq("is_active", true)
        .maybeSingle();

      if (powerErr || !power) throw Errors.SERVER_ERROR();

      const powerData = power as unknown as PowerRow;
      const cost = calculatePowerCost(powerData.base_cost, session.total_questions);
      const greenReward = calculateGreenReward(cost);

      // Spend purple diamonds from solver
      await diamondService.spendPurple(solverId, cost, "POWER_USED", `${powerUsed}:${sessionId}`);
      // Earn green diamonds for target
      await diamondService.earnGreen(session.target_id, greenReward, "POWER_REWARD", `${powerUsed}:${sessionId}`);

      // ─── Power effects ───
      switch (powerUsed) {
        case "SKIP": {
          // Mark correct, record answer, proceed
          await this.recordAnswer(sessionId, currentQuestion.id, selectedAnswer, true, powerUsed);
          await this.updateQuestionStats(currentQuestion.id, true);

          if (session.current_q >= session.total_questions) {
            return await this.completeSession(session);
          }

          await this.incrementCurrentQ(sessionId, session.current_q);
          return { is_correct: true, next_question: session.current_q + 1, session_status: "IN_PROGRESS" };
        }

        case "SKIP_ALL": {
          // Mark ALL remaining questions correct
          for (let i = questionIndex; i < questions.length; i++) {
            const q = questions[i] as unknown as QuestionRow;

            // Check if already answered
            const { data: alreadyDone } = await supabase
              .from("quiz_answers")
              .select("id")
              .eq("session_id", sessionId)
              .eq("question_id", q.id)
              .maybeSingle();

            if (!alreadyDone) {
              await this.recordAnswer(sessionId, q.id, 0, true, powerUsed);
              await this.updateQuestionStats(q.id, true);
            }
          }

          return await this.completeSession(session);
        }

        case "COPY": {
          return {
            power_result: { correct_answer_index: currentQuestion.correct_answer },
            awaiting_answer: true,
          };
        }

        case "HALF": {
          // Pick 2 wrong answers randomly
          const wrongIndices = [1, 2, 3, 4].filter((i) => i !== currentQuestion.correct_answer);
          const shuffledWrong = shuffleArray(wrongIndices);
          const removedIndices = shuffledWrong.slice(0, 2);

          return {
            power_result: { removed_indices: removedIndices },
            awaiting_answer: true,
          };
        }

        case "TIME_EXTEND": {
          return {
            power_result: { extra_seconds: 15 },
            awaiting_answer: true,
          };
        }

        case "HINT": {
          return {
            power_result: { hint_text: currentQuestion.hint_text ?? "" },
            awaiting_answer: true,
          };
        }
      }
    }

    // ─── Normal answer (no power or after SKIP) ───
    const isCorrect = selectedAnswer === currentQuestion.correct_answer;

    // Record answer
    await this.recordAnswer(sessionId, currentQuestion.id, selectedAnswer, isCorrect, powerUsed ?? null);
    // Update question stats
    await this.updateQuestionStats(currentQuestion.id, isCorrect);

    if (!isCorrect) {
      // FAILED
      await supabase
        .from("quiz_sessions")
        .update({ status: "FAILED", completed_at: new Date().toISOString() })
        .eq("id", sessionId);

      return { is_correct: false, session_status: "FAILED" };
    }

    // Correct AND last question
    if (session.current_q >= session.total_questions) {
      return await this.completeSession(session);
    }

    // Correct AND more questions
    await this.incrementCurrentQ(sessionId, session.current_q);
    return { is_correct: true, next_question: session.current_q + 1, session_status: "IN_PROGRESS" };
  }

  // ─── Get Session Result ────────────────────────────────────────
  async getSessionResult(sessionId: string, solverId: string) {
    const { data: session, error: sessErr } = await supabase
      .from("quiz_sessions")
      .select("*")
      .eq("id", sessionId)
      .eq("solver_id", solverId)
      .maybeSingle();

    if (sessErr || !session) throw Errors.SESSION_NOT_FOUND();

    const { data: answers, error: ansErr } = await supabase
      .from("quiz_answers")
      .select("*")
      .eq("session_id", sessionId)
      .order("created_at", { ascending: true });

    if (ansErr) throw Errors.SERVER_ERROR();

    return {
      session_id: session.id,
      solver_id: session.solver_id,
      target_id: session.target_id,
      status: session.status,
      current_q: session.current_q,
      total_questions: session.total_questions,
      expires_at: session.expires_at,
      completed_at: session.completed_at,
      answers: answers ?? [],
    };
  }

  // ─── Private helpers ───────────────────────────────────────────

  private async getActiveSession(sessionId: string, solverId: string): Promise<SessionRow> {
    const { data: session, error } = await supabase
      .from("quiz_sessions")
      .select("id, solver_id, target_id, status, current_q, total_questions, expires_at, completed_at")
      .eq("id", sessionId)
      .eq("solver_id", solverId)
      .maybeSingle();

    if (error || !session) throw Errors.SESSION_NOT_FOUND();

    const s = session as unknown as SessionRow;

    if (s.status !== "IN_PROGRESS") throw Errors.SESSION_NOT_FOUND();

    // Check expiry
    if (new Date(s.expires_at) < new Date()) {
      await supabase
        .from("quiz_sessions")
        .update({ status: "FAILED", completed_at: new Date().toISOString() })
        .eq("id", sessionId);

      throw Errors.TIME_UP();
    }

    return s;
  }

  private async createMatch(sessionId: string, solverId: string, targetId: string) {
    // Order user IDs for unique constraint
    const [user1, user2] = [solverId, targetId].sort();

    const { error: matchErr } = await supabase
      .from("matches")
      .insert({ user1_id: user1, user2_id: user2, quiz_session_id: sessionId });

    if (matchErr && matchErr.code !== "23505") {
      console.error("[quiz] Match insert error:", matchErr);
    }

    // Update session
    await supabase
      .from("quiz_sessions")
      .update({ status: "COMPLETED", completed_at: new Date().toISOString() })
      .eq("id", sessionId);

    // Send push to both users
    await Promise.all([
      NotificationService.sendPush(solverId, "new_match"),
      NotificationService.sendPush(targetId, "new_match"),
    ]);
  }

  private async completeSession(session: SessionRow) {
    await this.createMatch(session.id, session.solver_id, session.target_id);
    return { is_correct: true, matched: true, session_status: "COMPLETED" };
  }

  private async recordAnswer(
    sessionId: string,
    questionId: string,
    selectedAnswer: number,
    isCorrect: boolean,
    powerUsed: string | null,
  ) {
    const { error } = await supabase.from("quiz_answers").insert({
      session_id: sessionId,
      question_id: questionId,
      selected_answer: selectedAnswer,
      is_correct: isCorrect,
      power_used: powerUsed ?? null,
    });

    if (error) throw Errors.SERVER_ERROR();
  }

  private async updateQuestionStats(questionId: string, isCorrect: boolean) {
    const column = isCorrect ? "stats_correct" : "stats_wrong";

    const { data: q, error: readErr } = await supabase
      .from("questions")
      .select(`${column}`)
      .eq("id", questionId)
      .single();

    if (readErr || !q) return;

    const currentVal = (q as Record<string, number>)[column] ?? 0;

    await supabase
      .from("questions")
      .update({ [column]: currentVal + 1 })
      .eq("id", questionId);
  }

  private async incrementCurrentQ(sessionId: string, currentQ: number) {
    const { error } = await supabase
      .from("quiz_sessions")
      .update({ current_q: currentQ + 1 })
      .eq("id", sessionId);

    if (error) throw Errors.SERVER_ERROR();
  }
}

export const quizService = new QuizService();
