import jwt from "jsonwebtoken";

const generateAccessToken = (id: string) => {
  const secretKey = process.env.ACCESS_TOKEN_SECRET;

  if (secretKey) {
    return jwt.sign({ id }, secretKey, {
      expiresIn: "5m",
    });
  }
};

const generateRefreshToken = (id: string) => {
  const secretKey = process.env.REFRESH_TOKEN_SECRET;

  if (secretKey) {
    return jwt.sign({ id }, secretKey, {
      expiresIn: "1d",
    });
  }
};

export { generateAccessToken, generateRefreshToken };
