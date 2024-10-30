import { PrismaClient } from "@prisma/client";
import { Request, Response } from "express";

const prisma = new PrismaClient();

class ProductController {
  getAll = async (req: Request, res: Response) => {
    try {
      const products = await prisma.product.findMany({
        include: {
          category: true,
        },
      });
      res.status(200).json(products);
    } catch (error) {
      console.log(error);
    }
  };

  createProduct = async (req: Request, res: Response) => {
    try {
      const product = await prisma.product.create({
        data: {
          name: req.body.name,
          description: req.body.description,
          price: req.body.price,
          categoryId: req.body.categoryId,
        },
      });

      res.status(201).json({
        message: "Товар создан",
      });

      console.log(product);
    } catch (error) {
      console.log(error);
    }
  };

  updateProduct = async (req: Request, res: Response) => {
    try {
      const product = await prisma.product.update({
        where: {
          id: req.body.id,
        },
        data: {
          name: req.body.name,
          description: req.body.description,
          price: req.body.price,
          quantity: req.body.quantity,
          rating: req.body.rating,
          categoryId: req.body.categoryId
        },
      });

      res.status(200).json({
        message: "Товар обновлён",
      });

      console.log(product);
    } catch (error) {
      console.log(error);
    }
  };

  deleteProduct = async (req: Request, res: Response) => {
    try {
      const product = await prisma.product.delete({
        where: {
          id: req.body.id,
        },
      });

      res.status(204).json({
        message: "Товар удалён",
      });
    } catch (error) {
      console.log(error);
    }
  };

  getProductById = async (req: Request, res: Response) => {
    try {
      const product = await prisma.product.findUnique({
        where: {
          id: req.body.id,
        },
        include: {
          category: true,
        },
      });

      res.status(200).json(product);
    } catch (error) {
      console.log(error);
    }
  };

  getProductsByCategory = async (req: Request, res: Response) => {
    try {
      const products = await prisma.product.findMany({
        where: {
          categoryId: req.body.categoryId,
        },
        include: {
          category: true,
        },
      });

      res.status(200).json(products);
    } catch (error) {
      console.log(error);
    }
  };
}

export default new ProductController();
