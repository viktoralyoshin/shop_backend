import { Router } from "express";
import categoryRouter from "./category.router";
import productRouter from "./product.router";
import userRouter from "./user.router";

const router = Router();

router.use("/category", categoryRouter);
router.use("/product", productRouter);
router.use("/user", userRouter)

export default router;
