const express = require('express');
const app = express();
const auth = require('./routes/auth/auth');
const todos = require('./routes/todos/todos');
const user = require('./routes/user/user');
const authmiddleware = require('./middleware/auth');

require('dotenv').config()
var urlencodedParser = require("body-parser").urlencoded({ extended: false })

app.use(urlencodedParser);
app.use("/", auth);
app.use("/todos", authmiddleware, todos);
app.use("/", authmiddleware, user);

app.use('/userid', authmiddleware, (req, res, next) => {
  return res.status(200).json(req.middlewareId);
});

app.get('/', authmiddleware, async (req, res, next) => {
    return res.status(200).send('Api root');
});

app.listen(3000, () => {
  console.log(`Server is listening on port ${process.env.PORT || 3000}`);
});
