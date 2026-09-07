import { API_URL } from "@/lib/constants/api";

/**
 * Client for the public "can you answer me?" quiz endpoints (`/api/v1/web-quiz`).
 * No auth: the server rate-limits by IP and never returns correct answers
 * before an attempt is submitted.
 */
export interface BankQuestion {
  id: string;
  question_text: string;
  answers: string[];
}

export interface PublicQuizQuestion {
  question_text: string;
  answers: string[];
}

export interface PublicQuiz {
  slug: string;
  locale: string;
  nickname: string;
  plays: number;
  questions: PublicQuizQuestion[];
}

export interface AttemptResult {
  nickname: string;
  score: number;
  total: number;
  results: Array<{ chosen: number; correct: number; is_correct: boolean }>;
}

export interface CreateQuizInput {
  locale: string;
  nickname: string;
  age_confirmed: true;
  items: Array<{ bank_id: string; correct: number }>;
}

export class ApiError extends Error {
  constructor(
    public readonly status: number,
    public readonly code: string,
  ) {
    super(code);
  }
}

async function request<T>(path: string, init?: RequestInit): Promise<T> {
  const res = await fetch(`${API_URL}/api/v1/web-quiz${path}`, {
    ...init,
    headers: { "Content-Type": "application/json", ...(init?.headers ?? {}) },
  });
  if (!res.ok) {
    let code = `HTTP_${res.status}`;
    try {
      const body = (await res.json()) as { error?: { code?: string } };
      code = body?.error?.code ?? code;
    } catch {
      // body is not JSON — keep the HTTP status as the code
    }
    throw new ApiError(res.status, code);
  }
  return (await res.json()) as T;
}

export async function fetchBank(locale: string): Promise<BankQuestion[]> {
  const data = await request<{ questions: BankQuestion[] }>(`/bank?locale=${encodeURIComponent(locale)}`);
  return data.questions;
}

export function createQuiz(input: CreateQuizInput): Promise<{ slug: string }> {
  return request<{ slug: string }>("", { method: "POST", body: JSON.stringify(input) });
}

export function fetchQuiz(slug: string): Promise<PublicQuiz> {
  return request<PublicQuiz>(`/${encodeURIComponent(slug)}`);
}

export function submitAttempt(slug: string, answers: number[]): Promise<AttemptResult> {
  return request<AttemptResult>(`/${encodeURIComponent(slug)}/attempt`, {
    method: "POST",
    body: JSON.stringify({ answers }),
  });
}

/** Share URL is locale-less on purpose: short, and Netlify serves the visitor's own language. */
export const QUIZ_QUESTION_COUNT = 5;
export const SLUG_PATTERN = /^[A-Za-z2-9]{8}$/;
