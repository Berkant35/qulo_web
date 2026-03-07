import type { Request, Response, NextFunction } from "express";
import { diamondService } from "../services/diamond.service.js";
import type { HistoryQuery, PurchaseInput } from "../validators/diamond.validator.js";

export async function getBalanceHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const userId = req.user!.userId;
    const result = await diamondService.getBalance(userId);
    res.json(result);
  } catch (err) {
    next(err);
  }
}

export async function getHistoryHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const userId = req.user!.userId;
    const { page, limit } = req.query as unknown as HistoryQuery;
    const result = await diamondService.getHistory(userId, page, limit);
    res.json(result);
  } catch (err) {
    next(err);
  }
}

export async function purchaseHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const userId = req.user!.userId;
    const { receipt, platform } = req.body as PurchaseInput;

    // TODO: Validate receipt with Apple/Google servers
    // For now, just acknowledge the receipt format is valid
    res.json({
      message: "Purchase received",
      userId,
      platform,
      receiptLength: receipt.length,
    });
  } catch (err) {
    next(err);
  }
}
