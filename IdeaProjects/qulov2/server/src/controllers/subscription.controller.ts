import { Request, Response, NextFunction } from 'express';
import { subscriptionService } from '../services/subscription.service.js';

export const getSubscriptionStatusHandler = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const status = await subscriptionService.getStatus(req.user!.userId);
    const limits = subscriptionService.getLimits(status.plan);
    res.json({ subscription: status, limits });
  } catch (error) {
    next(error);
  }
};
