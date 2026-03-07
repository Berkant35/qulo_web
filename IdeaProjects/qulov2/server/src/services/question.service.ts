import { supabase } from "../config/supabase.js";
import { AppError, Errors } from "../utils/errors.js";
import type { CreateQuestionInput, UpdateQuestionInput } from "../validators/question.validator.js";

export class QuestionService {
  async getMyQuestions(userId: string) {
    const { data, error } = await supabase
      .from("questions")
      .select("*")
      .eq("user_id", userId)
      .order("order_num", { ascending: true });

    if (error) {
      throw Errors.SERVER_ERROR();
    }

    return data;
  }

  async createQuestion(userId: string, input: CreateQuestionInput) {
    // Check count < 6
    const { count, error: countError } = await supabase
      .from("questions")
      .select("*", { count: "exact", head: true })
      .eq("user_id", userId);

    if (countError) {
      throw Errors.SERVER_ERROR();
    }

    if ((count ?? 0) >= 6) {
      throw Errors.MAX_QUESTIONS_REACHED();
    }

    const { data, error } = await supabase
      .from("questions")
      .insert({
        user_id: userId,
        order_num: input.order_num,
        question_text: input.question_text,
        correct_answer: input.correct_answer,
        answer_1: input.answer_1,
        answer_2: input.answer_2,
        answer_3: input.answer_3,
        answer_4: input.answer_4,
        hint_text: input.hint_text ?? null,
      })
      .select("*")
      .single();

    if (error) {
      // Unique constraint violation (user_id, order_num)
      if (error.code === "23505") {
        throw new AppError("DUPLICATE_ORDER_NUM", 409, "Question with this order number already exists");
      }
      throw Errors.SERVER_ERROR();
    }

    return data;
  }

  async updateQuestion(userId: string, orderNum: number, input: UpdateQuestionInput) {
    const { data, error } = await supabase
      .from("questions")
      .update(input)
      .eq("user_id", userId)
      .eq("order_num", orderNum)
      .select("*")
      .single();

    if (error) {
      throw Errors.SERVER_ERROR();
    }

    if (!data) {
      throw Errors.SESSION_NOT_FOUND();
    }

    return data;
  }

  async deleteQuestion(userId: string, orderNum: number) {
    const { error, count } = await supabase
      .from("questions")
      .delete({ count: "exact" })
      .eq("user_id", userId)
      .eq("order_num", orderNum);

    if (error) {
      throw Errors.SERVER_ERROR();
    }

    if (count === 0) {
      throw Errors.SESSION_NOT_FOUND();
    }
  }

  async getQuestionCount(userId: string) {
    const { count, error } = await supabase
      .from("questions")
      .select("*", { count: "exact", head: true })
      .eq("user_id", userId);

    if (error) {
      throw Errors.SERVER_ERROR();
    }

    return { count: count ?? 0 };
  }
}

export const questionService = new QuestionService();
