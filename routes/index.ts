import { Router } from "express";
import categoryRouter from "./category.router";
import productRouter from "./product.router";
import userRouter from "./user.router";
import bucketRouter from "./bucket.router"
import wishlistRouter from "./wishlist.router"

const router = Router();

router.use("/category", categoryRouter);
router.use("/product", productRouter);
router.use("/user", userRouter)
router.use("/bucket", bucketRouter)
router.use("/wishlist", wishlistRouter)

export default router;
