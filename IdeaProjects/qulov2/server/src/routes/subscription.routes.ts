import { Router } from 'express';
import { authMiddleware } from '../middleware/auth.js';
import { generalLimiter } from '../middleware/rateLimit.js';
import { getSubscriptionStatusHandler } from '../controllers/subscription.controller.js';

const router = Router();

router.use(authMiddleware, generalLimiter);

router.get('/status', getSubscriptionStatusHandler);

export default router;
