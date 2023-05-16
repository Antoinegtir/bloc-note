const executeQuery = require('../routes/todos/todos.query').executeQuery;

module.exports = (req, res, next) => {
    const id = req.params.id;

    if (id) {
        executeQuery(req, res, next, id);
    } else {
        res.status(500).json({ "msg": "Internal server error" });
    }
}
