import { PrismaClient } from "@prisma/client";
import { Request, Response } from "express";
import bcrypt from "bcrypt";
import {
  generateAccessToken,
  generateRefreshToken,
} from "../utils/generateToken";

const prisma = new PrismaClient();

class UserController {
  signUp = async (req: Request, res: Response) => {
    try {
      const existUser = await prisma.user.findUnique({
        where: {
          phoneNumber: req.body.phoneNumber,
        },
      });

      if (!existUser) {
        const hashPassword = await bcrypt.hash(req.body.password, 10);

        const user = await prisma.user.create({
          data: {
            phoneNumber: req.body.phoneNumber,
            email: req.body.email,
            password: hashPassword,
            firstName: req.body.firstName,
            lastName: req.body.lastName,
          },
        });

        const refreshToken = generateRefreshToken(user.id);
        const accessToken = generateAccessToken(user.id);

        res
          .status(201)
          .cookie("refreshToken", refreshToken, {
            httpOnly: true,
          })
          .cookie("accessToken", accessToken)
          .json({
            message: "Регистрация прошла успешно",
          });

        console.log(user);
      } else {
        res.json({
          message: "Пользователь с таким номером телефона уже существует",
        });
      }
    } catch (error) {
      console.log(error);
    }
  };
}

export default new UserController();
