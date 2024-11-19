import { PrismaClient, Prisma } from "@prisma/client";
import { Request, Response } from "express";
import bcrypt from "bcrypt";
import {
  generateAccessToken,
  generateRefreshToken,
} from "../utils/generateToken";
import jwt, { JsonWebTokenError } from "jsonwebtoken";
import { error } from "console";
import validateToken from "../utils/validateToken";

const prisma = new PrismaClient();

class UserController {
  getAll = async (req: Request, res: Response) => {
    try {
      const users = await prisma.user.findMany({
        include: {
          bucket: {
            include: {
              products: {
                include: {
                  category: true,
                },
              },
            },
          },
          wishlist: {
            include: {
              products: {
                include: {
                  category: true,
                },
              },
            },
          },
        },
      });

      res.json(users);
    } catch (error) {
      console.log(error);
    }
  };

  getById = async (req: Request, res: Response) => {
    try {
      const user = await prisma.user.findUnique({
        where: {
          id: req.params.id,
        },
        include: {
          bucket: {
            include: {
              products: {
                include: {
                  category: true,
                },
              },
            },
          },
          wishlist: {
            include: {
              products: {
                include: {
                  category: true,
                },
              },
            },
          },
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
          data: {
            ...user,
            bucket: {
              create: {},
            },
            wishlist: {
              create: {},
            },
          },
          include: {
            bucket: {
              include: {
                products: {
                  include: {
                    category: true,
                  },
                },
              },
            },
            wishlist: {
              include: {
                products: {
                  include: {
                    category: true,
                  },
                },
              },
            },
          },
        });

        const refreshToken = generateRefreshToken(newUser.id);
        const accessToken = generateAccessToken(newUser.id);

        const { password, ...userData } = newUser;

        res
          .status(201)
          .cookie("refreshToken", refreshToken, {
            httpOnly: true,
            maxAge: 1000 * 60 * 60 * 24 * 7,
            sameSite: "none",
          })
          .cookie("accessToken", accessToken, {
            maxAge: 99999999,
            sameSite: "none",
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
        include: {
          bucket: {
            include: {
              products: {
                include: {
                  category: true,
                },
              },
            },
          },
          wishlist: {
            include: {
              products: {
                include: {
                  category: true,
                },
              },
            },
          },
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
              sameSite: "none",
            })
            .cookie("accessToken", accessToken, {
              maxAge: 99999999,
              sameSite: "none",
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
            include: {
              bucket: {
                include: {
                  products: {
                    include: {
                      category: true,
                    },
                  },
                },
              },
              wishlist: {
                include: {
                  products: {
                    include: {
                      category: true,
                    },
                  },
                },
              },
            },
          });

          if (user) {
            const accessToken = generateAccessToken(user.id);
            res
              .cookie("accessToken", accessToken, {
                maxAge: 99999999,
                sameSite: "none",
              })
              .json(user);
            console.log("Токен обновлён");
          }
        } catch (error) {
          console.log(error);
          res.status(401).json({ message: "Неавторизован" });
        }
      } else {
        res.status(401).json({
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

      console.log(accessToken);

      if (accessToken) {
        const secretKey: any = process.env.ACCESS_TOKEN_SECRET;

        try {
          const verify: any = jwt.verify(accessToken, secretKey);

          const user = await prisma.user.findUnique({
            where: {
              id: verify.id,
            },
            include: {
              bucket: {
                include: {
                  products: {
                    include: {
                      category: true,
                    },
                  },
                },
              },
              wishlist: {
                include: {
                  products: {
                    include: {
                      category: true,
                    },
                  },
                },
              },
            },
          });

          res.status(200).json(user);
        } catch (error: unknown) {
          if (error instanceof JsonWebTokenError) {
            if (error.name == "TokenExpiredError") {
              res.status(401).json(error.name);
            } else {
              res.status(401).json({
                message: "Токен не существует",
              });
            }
          }
          console.log(error);
        }
      } else {
        res.status(401).json({
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
          sameSite: "none",
        })
        .cookie("accessToken", "", {
          maxAge: 0,
          sameSite: "none",
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
