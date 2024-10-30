import { Router } from "express";
import categoryController from "../controllers/category.controller";

const router = Router();

router.get("/", categoryController.getAll);
router.post("/create", categoryController.createCategory);
router.post('/update', categoryController.updateCategory);
router.post('/delete', categoryController.deleteCategory);
router.get('/getById', categoryController.getCategoryById);
router.get('/getByName', categoryController.getCategoryByName);

export default router;
