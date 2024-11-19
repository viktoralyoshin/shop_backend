import { PrismaClient } from "@prisma/client";
import { Request, Response } from "express";

const prisma = new PrismaClient();

class WishlistController {
  getWishlistByUser = async (req: Request, res: Response) => {
    try {
      const wishlist = await prisma.wishlist.findUnique({
        where: {
          userId: req.params.id,
        },
        include: {
          products: {
            include: {
              category: true,
            },
          },
        },
      });

      res.status(200).json(wishlist);
    } catch (error) {
      console.log(error);
    }
  };

  addProductToWishlist = async (req: Request, res: Response) => {
    try {
      const { userId, productId } = req.body;

      const wishlist = await prisma.wishlist.update({
        where: {
          userId: userId,
        },
        data: {
          products: {
            connect: {
              id: productId,
            },
          },
        },
        include: {
          products: {
            include: {
              category: true,
            },
          },
        },
      });

      res.status(200).json(wishlist);
    } catch (error) {
      console.log(error);
    }
  };

  deleteProductFromWishlist = async (req: Request, res: Response) => {
    try {
      const { userId, productId } = req.body;

      const wishlist = await prisma.wishlist.update({
        where: {
          userId: userId,
        },
        data: {
          products: {
            disconnect: {
              id: productId,
            },
          },
        },
        include: {
          products: {
            include: {
              category: true,
            },
          },
        },
      });

      res.status(200).json(wishlist);
    } catch (error) {
      console.log(error);
    }
  };
}

export default new WishlistController();
