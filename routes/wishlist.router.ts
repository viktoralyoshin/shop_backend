import { Router } from "express";
import wishlistController from "../controllers/wishlist.controller";

const router = Router();

router.get("/:id", wishlistController.getWishlistByUser);
router.post("/add", wishlistController.addProductToWishlist);
router.post("/delete", wishlistController.deleteProductFromWishlist)

export default router;
