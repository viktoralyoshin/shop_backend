import { PrismaClient, Prisma } from "@prisma/client";
import { Request, Response } from "express";
import bcrypt from "bcrypt";
import {
  generateAccessToken,
  generateRefreshToken,
} from "../utils/generateToken";
import jwt from "jsonwebtoken";
import { error } from "console";
import validateToken from "../utils/validateToken";

const prisma = new PrismaClient();

class UserController {
  getAll = async (req: Request, res: Response) => {
    try {
      const users = await prisma.user.findMany();

      res.json(users);
    } catch (error) {
      console.log(error);
    }
  };

  getById = async (req: Request, res: Response) => {
    try {
      const user = await prisma.user.findUnique({
        where: {
          id: req.body.id,
        },
      });

      res.json(user);
    } catch (error) {
      console.log(error);
    }
  };

  signUp = async (req: Request, res: Response) => {
    try {
      const user: Prisma.UserCreateInput = req.body;

      const existUser = await prisma.user.findUnique({
        where: {
          phoneNumber: user.phoneNumber,
        },
      });

      if (!existUser) {
        user.password = await bcrypt.hash(user.password, 10);

        const newUser = await prisma.user.create({
          data: user,
        });

        const refreshToken = generateRefreshToken(newUser.id);
        const accessToken = generateAccessToken(newUser.id);

        const { password, ...userData } = newUser;

        res
          .status(201)
          .cookie("refreshToken", refreshToken, {
            httpOnly: true,
            maxAge: 1000 * 60 * 60 * 24 * 7,
          })
          .cookie("accessToken", accessToken, {
            maxAge: 1000 * 60 * 30,
          })
          .json(userData);

        console.log(userData);
      } else {
        res.json({
          message: "Пользователь с таким номером телефона уже существует",
        });
      }
    } catch (error) {
      console.log(error);
    }
  };

  signIn = async (req: Request, res: Response) => {
    try {
      const user = await prisma.user.findUnique({
        where: {
          phoneNumber: req.body.phoneNumber,
        },
      });

      if (user) {
        const comparePassword = await bcrypt.compare(
          req.body.password,
          user.password
        );

        if (comparePassword) {
          const refreshToken = generateRefreshToken(user.id);
          const accessToken = generateAccessToken(user.id);

          res
            .status(201)
            .cookie("refreshToken", refreshToken, {
              httpOnly: true,
              maxAge: 1000 * 60 * 60 * 24 * 7,
            })
            .cookie("accessToken", accessToken, {
              maxAge: 1000 * 60 * 30,
            })
            .json(user);
          console.log(error);
        } else {
          res.json({
            message: "Неверный пароль",
          });
        }
      }
    } catch (error) {
      console.log(error);
    }
  };

  refreshToken = async (req: Request, res: Response) => {
    try {
      const { refreshToken } = req.cookies;

      if (validateToken(refreshToken)) {
        const secretKey: any = process.env.REFRESH_TOKEN_SECRET;

        try {
          const verify: any = jwt.verify(refreshToken, secretKey);

          const user = await prisma.user.findUnique({
            where: {
              id: verify.id,
            },
          });

          if (user) {
            const accessToken = generateAccessToken(user.id);

            res.json(user).cookie("accessToken", accessToken, {
              maxAge: 1000 * 60 * 30,
            });
          }
        } catch (error) {
          console.log(error);
          res.json({ message: "Неавторизован" });
        }
      } else {
        res.json({
          message: "Токен не существует",
        });
      }
    } catch (error) {
      console.log(error);
    }
  };

  verify = async (req: Request, res: Response) => {
    try {
      const { accessToken } = req.cookies;

      if (validateToken(accessToken)) {
        const secretKey: any = process.env.ACCESS_TOKEN_SECRET;

        try {
          const verify: any = jwt.verify(accessToken, secretKey);

          const user = await prisma.user.findUnique({
            where: {
              id: verify.id,
            },
          });

          res.json(user);
        } catch (error) {
          console.log(error);
          res.json({ message: "Неавторизован" });
        }
      } else {
        res.json({
          message: "Токен не существует",
        });
      }
    } catch (error) {
      console.log(error);
    }
  };

  signOut = (req: Request, res: Response) => {
    try {
      res
        .status(201)
        .cookie("refreshToken", "", {
          httpOnly: true,
          maxAge: 0,
        })
        .cookie("accessToken", "", {
          maxAge: 0,
        })
        .json({
          message: "Выход выполнен успешно",
        });
    } catch (error) {
      console.log(error);
    }
  };
}

export default new UserController();
