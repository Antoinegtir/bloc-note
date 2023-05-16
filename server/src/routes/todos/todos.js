const express = require('express');
const { get_all_todo_informations, view_the_todo, create_todo, update_todo, delete_todo } = require('./todos.query');
const router = express.Router();
const notfoundmiddleware = require('../../middleware/notFound');

router.get('/',  (req, res, next) => {
    get_all_todo_informations((err, code) => {
        if (err)
            return res.status(500).json({ msg: "Internal server error" });
        res.status(200).json(code);
    }); 
});

router.get('/:id',  notfoundmiddleware,  (req, res, next) => {
    if (!req.params.id)
      return res.status(400).json({ msg: "Bad parameter" });
    view_the_todo(req.params.id, (err, code) => {
        if (err)
            return res.status(500).json({ msg: "Internal server error" });
        res.status(200).json(code);
    });
});

router.post('/',  (req, res, next) => {
    let currentDateTime = new Date();
    currentDateTime.setHours(currentDateTime.getHours() + 2);
    currentDateTime = currentDateTime.toISOString().slice(0, 19).replace('T', ' ');
    create_todo(req.body.title, req.body.description, currentDateTime, currentDateTime, req.body.user_id, req.body.status, (err, results) => {
        if (err)
            return res.status(500).json({ msg: "Internal server error" });
        res.status(201).json(results);
    });
});

router.put('/:id',  (req, res, next) => {
    if (!req.params.id)
      return res.status(400).json({ msg: "Bad parameter" });
    update_todo(req.params.id, req.body.title, req.body.description, req.body.due_time, req.body.status, req.middlewareId, (err, results) => {
        if (err)
            return res.status(500).json({ msg: "Internal server error" });
        res.status(200).json(results);
    });
});

router.delete('/:id',  notfoundmiddleware, (req, res, next) => {
    if (!req.params.id)
      return res.status(400).json({ msg: "Bad parameter" });
    delete_todo(req.params.id, (err) => {
        if (err)
            return res.status(500).json({ msg: "Internal server error" });
        res.status(200).json({ msg: `Successfully deleted record number: ${req.params.id}` });
    }); 
});

module.exports = router;
