const express = require('express');
const {get_all_user_informations, get_user_todos, update_user, delete_user, get_user_by_info} = require('./user.query');
const router = express.Router();
const notfoundmiddleware = require('../../middleware/notFound');

router.get('/user', (req, res, next) => {
    get_all_user_informations((err, code) => {
        if (err)
            return res.status(500).json({ msg: "Internal server error" });
        const codeObjects = code;
        res.status(200).json(codeObjects[0]);
    });
});

router.get('/users/:info', (req, res, next) => {
    get_user_by_info(req.params.info, (err, data) => {
        if (err)
            return res.status(500).json({ msg: "Internal server error" });
        res.status(200).json(data);
    }); 
});

router.get('/user/todos', (req, res, next) => {
    get_user_todos(req.middlewareId, (error, todos) => {  
        if (error) {
            return res.status(500).json({ message: 'Internal server error' });
        }
        return res.status(200).json(todos);
    });
});

router.put("/users/:id", (req, res, next) => {
    if (!req.body.email || !req.body.password || !req.body.name || !req.body.firstname)
      return res.status(400).json({ msg: "Bad parameter" });
    update_user(req.params.id, req.body.email, req.body.name, req.body.password, req.body.firstname, (code, updateUser) => {
        if (code == 84) return;
        res.status(200).json(updateUser);
    }); 
});

router.delete("/users/:id", notfoundmiddleware,(req, res, next) => {
    delete_user(req.params.id, (err, code) => {
        if (err)
            return res.status(500).json({ msg: "Internal server error" });
        res.status(200).json({ msg: `Successfully deleted record number: ${req.params.id}` });
    }); 
});

module.exports = router;
