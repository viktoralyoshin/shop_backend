import express, { Express } from "express";
import cors from "cors";
import router from "./routes/index";
import cookieParser from "cookie-parser";
import path from 'path';

const bodyParser = require("body-parser");
const fileUpload = require('express-fileupload');

const PORT = process.env.PORT || 5000;

const app: Express = express();

const corsOptions = {
  origin: process.env.FRONT_URL,
  credentials: true,
};

app.use(cors(corsOptions));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser())
app.use(fileUpload())
app.use(express.static(path.resolve(__dirname, 'public')))
app.use("/api", router);

const start = async () => {
  try {
    app.listen(PORT, () => console.log(`Server started on port ${PORT}`));
  } catch (e) {
    console.log(e);
  }
};

start();
