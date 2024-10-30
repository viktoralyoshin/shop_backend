import { Response, Request } from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

class CategoryController {
  getAll = async (req: Request, res: Response) => {
    try {
      const categories = await prisma.category.findMany();
      res.status(200).json(categories);
    } catch (error) {
      console.log(error);
    }
  };
  createCategory = async (req: Request, res: Response) => {
    try {
      const categoryName: string = req.body.name;

      const existName = await prisma.category.findFirst({
        where: {
          name: categoryName,
        },
      });

      if (!existName) {
        const category = await prisma.category.create({
          data: {
            name: categoryName,
          },
        });

        res.status(201).json({
          message: "Категория создана",
        });

        console.log(category);
      } else {
        res.json({
          message: "Категория с таким именем уже существует",
        });
      }
    } catch (error) {
      console.log(error);
    }
  };

  updateCategory = async (req: Request, res: Response) => {
    try {
      const category = await prisma.category.update({
        where: {
          id: req.body.id,
        },

        data: {
          name: req.body.name,
        },
      });

      res.status(200).json({
        message: "Категория обновлена",
      });

      console.log(category);
    } catch (error) {
      console.log(error);
    }
  };

  deleteCategory = async (req: Request, res: Response) => {
    try {
      const category = await prisma.category.delete({
        where: {
          id: req.body.id,
        },
      });

      res.status(204).json({
        message: "Категория удалена",
      });
    } catch (error) {
      console.log(error);
    }
  };

  getCategoryById = async (req: Request, res: Response) => {
    try {
      const category = await prisma.category.findFirst({
        where: {
          id: req.body.id,
        },
      });

      res.status(200).json(category);
    } catch (error) {
      console.log(error);
    }
  };

  getCategoryByName = async (req: Request, res: Response) => {
    try {
      const category = await prisma.category.findUnique({
        where: {
          name: req.body.name,
        },
      });

      res.status(200).json(category);
    } catch (error) {
      console.log(error);
    }
  };
}

export default new CategoryController();
