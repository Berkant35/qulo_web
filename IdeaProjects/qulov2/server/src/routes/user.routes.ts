import { Router } from "express";
import multer from "multer";
import { authMiddleware } from "../middleware/auth.js";
import { generalLimiter } from "../middleware/rateLimit.js";
import { validate } from "../middleware/validate.js";
import {
  updateProfileSchema,
  updateDetailsSchema,
  updateLocationSchema,
  updatePushTokenSchema,
} from "../validators/user.validator.js";
import {
  getMeHandler,
  updateProfileHandler,
  updateDetailsHandler,
  updateLocationHandler,
  updatePushTokenHandler,
  uploadPhotoHandler,
  deletePhotoHandler,
  boostHandler,
  deleteAccountHandler,
} from "../controllers/user.controller.js";
import { AppError } from "../utils/errors.js";

const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
  fileFilter: (_req, file, cb) => {
    if (file.mimetype === "image/jpeg" || file.mimetype === "image/png") {
      cb(null, true);
    } else {
      cb(new AppError("INVALID_FILE_TYPE", 400, "Only jpg and png files are allowed"));
    }
  },
});

const router = Router();

// All routes require authentication and general rate limiting
router.use(authMiddleware, generalLimiter);

router.get("/me", getMeHandler);
router.patch("/me", validate(updateProfileSchema), updateProfileHandler);
router.patch("/me/details", validate(updateDetailsSchema), updateDetailsHandler);
router.patch("/me/location", validate(updateLocationSchema), updateLocationHandler);
router.patch("/me/push-token", validate(updatePushTokenSchema), updatePushTokenHandler);
router.post("/me/photos", upload.single("photo"), uploadPhotoHandler);
router.post("/me/boost", boostHandler);
router.delete("/me/photos/:index", deletePhotoHandler);
router.delete("/me", deleteAccountHandler);

export default router;
