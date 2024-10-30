import { Router } from "express";
import userController from "../controllers/user.controller";

const router = Router();

router.post("/signUp", userController.signUp);

export default router;
