import { Router } from "express";
import userController from "../controllers/user.controller";

const router = Router();

router.post("/signUp", userController.signUp);
router.post("/signIn", userController.signIn);
router.post("/verify", userController.verify);
router.post("/signOut", userController.signOut);
router.post("/refreshToken", userController.refreshToken)
router.get("/getAll", userController.getAll)
router.get("/:id", userController.getById)

export default router;
