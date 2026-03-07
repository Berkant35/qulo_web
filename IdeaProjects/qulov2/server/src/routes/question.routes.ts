import { Router } from "express";
import { generalLimiter } from "../middleware/rateLimit.js";
import { validate } from "../middleware/validate.js";
import { authMiddleware } from "../middleware/auth.js";
import { createQuestionSchema, updateQuestionSchema } from "../validators/question.validator.js";
import {
  getMyQuestionsHandler,
  createQuestionHandler,
  updateQuestionHandler,
  deleteQuestionHandler,
  getQuestionCountHandler,
} from "../controllers/question.controller.js";

const router = Router();

// All routes require authentication + general rate limit
router.use(authMiddleware, generalLimiter);

router.get("/me", getMyQuestionsHandler);
router.post("/me", validate(createQuestionSchema), createQuestionHandler);
router.put("/me/:order", validate(updateQuestionSchema), updateQuestionHandler);
router.delete("/me/:order", deleteQuestionHandler);
router.get("/count/me", getQuestionCountHandler);

export default router;
