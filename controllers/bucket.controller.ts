
import { PrismaClient } from "@prisma/client";
import { Request, Response } from "express";

const prisma = new PrismaClient();

class BucketController {
  getBucketByUser = async (req: Request, res: Response) => {
    try {
      const bucket = await prisma.bucket.findUnique({
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

      res.status(200).json(bucket);
    } catch (error) {
      console.log(error);
    }
  };

  addProductToBucket = async (req: Request, res: Response) => {
    try {
      const { userId, productId } = req.body;

      const bucket = await prisma.bucket.update({
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

      res.status(200).json(bucket);
    } catch (error) {
      console.log(error);
    }
  };

  deleteProductFromBucket = async (req: Request, res: Response) => {
    try {
      const { userId, productId } = req.body;

      const bucket = await prisma.bucket.update({
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

      res.status(200).json(bucket);
    } catch (error) {
      console.log(error);
    }
  };
}

export default new BucketController();
