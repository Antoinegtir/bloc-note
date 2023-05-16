const db = require('../../config/db');

function get_all_todo_informations(callback) {
    db.query('SELECT * FROM todo', (error, results) => {
        if (error) {
            callback(error, null);
        } else {
            callback(null, results);
        }
    });
}

function view_the_todo(id, callback) {
    db.query('SELECT * FROM todo WHERE id = ?', id, (error, results) => {
        if (error) {
            callback(error, null);
        } else {
            callback(null, results);
        }
    });
}

function executeQuery(req, res, next, id) {
    db.execute('SELECT * FROM `todo` WHERE id = ?', [id], (err, results, fields) => {
        if (err) {
            res.status(500).json({ "msg": "Internal server error" });
        } else {
            if (results.length > 0) {
                next();
            } else {
                res.status(404).json({ "msg": "Not found" });
            }
        }
    });
}

function create_todo(title, description, created_at, due_time, user_id, status, callback) {
    db.query('INSERT INTO todo (title, description, created_at, due_time, user_id, status) VALUES (?, ?, ?, ?, ?, ?)', [title, description, created_at, due_time, user_id, status], (error, results) => {
        if (error) {
            console.log(error)
          callback(error, null);
        } else {
            const todo = {
                id: results.insertId,
                title: title,
                description: description,
                created_at: created_at,
                due_time: due_time,
                user_id: user_id,
                status: status
            };
            callback(null, todo);
        }
    });
}

function update_todo(id, title, description, due_time, status, user_id, callback) {
    db.execute('UPDATE todo SET title = ?, description = ?, due_time = ?, status = ? WHERE id = ?', [title, description, due_time, status, id], (error) => {
        if (error) {
            callback(error);
          } else {
            const todo = {
                title: title,
                description: description,
                due_time: due_time,
                user_id: user_id,
                status: status
            };
            callback(null, todo);
        }
    });
}

function delete_todo(id, callback) {
    db.query('DELETE FROM todo WHERE id = ?', id, (error) => {
        if (error) {
            callback(error);
        } else {
            callback(null);
        }
    });
}

module.exports = {
    get_all_todo_informations,
    view_the_todo,
    create_todo,
    update_todo,
    delete_todo,
    executeQuery
};
