import { Router } from "express";
import bucketController from "../controllers/bucket.controller";

const router = Router();

router.get("/:id", bucketController.getBucketByUser);
router.post("/add", bucketController.addProductToBucket);
router.post("/delete", bucketController.deleteProductFromBucket)

export default router;
