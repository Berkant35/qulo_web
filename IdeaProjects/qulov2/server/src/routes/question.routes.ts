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
  getQuestionAnalyticsHandler,
  getWeeklyReportHandler,
} from "../controllers/question.controller.js";
import { getPendingChangesHandler, queueChangeHandler, cancelPendingChangeHandler } from "../controllers/pending-change.controller.js";
import { queueChangeSchema } from "../validators/pending-change.validator.js";
import { aiSuggestHandler } from "../controllers/ai-suggest.controller.js";
import { aiSuggestSchema } from "../validators/ai-suggest.validator.js";

const router = Router();

// All routes require authentication + general rate limit
router.use(authMiddleware, generalLimiter);

router.get("/me", getMyQuestionsHandler);
router.post("/me", validate(createQuestionSchema), createQuestionHandler);
router.put("/me/:order", validate(updateQuestionSchema), updateQuestionHandler);
router.delete("/me/:order", deleteQuestionHandler);
router.get("/count/me", getQuestionCountHandler);
router.get("/me/analytics", getQuestionAnalyticsHandler);
router.get("/me/weekly-report", getWeeklyReportHandler);
router.get("/me/pending", getPendingChangesHandler);
router.post("/me/:order/queue-change", validate(queueChangeSchema), queueChangeHandler);
router.delete("/me/pending/:changeId", cancelPendingChangeHandler);
router.post("/ai-suggest", validate(aiSuggestSchema), aiSuggestHandler);

export default router;
