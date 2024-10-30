import { Router } from "express";
import productController from "../controllers/product.controller";

const router = Router();

router.get("/", productController.getAll);
router.post("/create", productController.createProduct);
router.post("/update", productController.updateProduct);
router.post("/delete", productController.deleteProduct);
router.get("/getById", productController.getProductById);
router.get("/getByCategory", productController.getProductsByCategory);

export default router;