import express, {Express} from "express";
import cors from "cors";
import router from "./routes/index";

var bodyParser = require('body-parser');

const PORT = process.env.PORT || 5000

const app: Express = express()
app.use(cors())
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use('/api', router)

const start = async () => {
    try {
        app.listen(PORT, () => console.log(`Server started on port ${PORT}`))
    } catch (e) {
        console.log(e)
    }
}


start()