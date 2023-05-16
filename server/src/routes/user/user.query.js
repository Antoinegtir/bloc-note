const db = require('../../config/db');
const bcrypt = require('bcryptjs');

function delete_user(userId, callback) {
    db.execute('DELETE FROM user WHERE id = ?', [userId], (err, res, fields) => {
        if (err)
          return callback(84);
        return callback(0);
    });  
}

function get_all_user_informations(callback) {
    db.query('SELECT id, email, password, created_at, firstname, name FROM user', (error, results) => {
      if (error) {
        return callback(error, null);
      } else {
        return callback(null, results);
      }
    });
}

function get_user_todos(userId, callback) {
  db.execute('SELECT * FROM todo WHERE user_id = ?',
    [userId],
    (error, results) => {
      if (error) {
        callback(error, null);
      } else {
        callback(null, results);
      }
    }
  );
}

function update_user(userId, email, name, password, firstname, callback) {
  const hashedPassword = bcrypt.hashSync(password, 10);
    db.execute('UPDATE user SET email = ?, name = ?, password = ?, firstname = ? WHERE id = ?', [email, name, hashedPassword, firstname, userId], (err, res, fields) => {
        if (err) {
          return callback(err, null);
        } else {
          let currentDateTime = new Date();
          currentDateTime.setHours(currentDateTime.getHours() + 2);
          currentDateTime = currentDateTime.toISOString().slice(0, 19).replace('T', ' ');
          const userUpdate = {
            id: userId,
            email: email,
            create_at: currentDateTime,
            firstname: firstname,
            name: name,
          };
          return callback(null, userUpdate);
        }
    });
}

function get_user_by_id(info, callback) { 
  db.execute('SELECT id, email, password, created_at, firstname, name FROM user WHERE id = ?', [info], (err, results) => {
      if (err)
        return callback(err, null);
      if (results.length == 0)
        return callback(`User with info ${info} not found.`, null);
      const user = results[0];
      return callback(null, user);
  });
}

function get_user_by_email(info, callback) { 
  db.execute('SELECT id, email, password, created_at, firstname, name FROM user WHERE email = ?', [info], (err, results) => {
      if (err)
        return callback(err, null);
      if (results.length == 0)
        return callback(`User with info ${info} not found.`, null);
      const user = results[0];
      return callback(null, user);
  });
}

function create_user(email, password, name, firstname, callback)
{
    db.execute('INSERT INTO user (email, password, name, firstname) VALUES (?, ?, ?, ?)', [email, password, name, firstname], (err, res, fields) => {
        if (err) 
          return callback(84, null);
        get_user_by_id(res.insertId, (err, user) => {
          if (err) 
            return callback(84, null);
          return callback(0, user);
        });
      });
}

function get_user_by_info(info, callback) { 
    db.execute('SELECT id, email, password, created_at, firstname, name FROM user WHERE id = ? OR email = ?', [info, info], (err, results) => {
        if (err)
          return callback(err, null);
        if (results.length == 0)
          return callback(`User with info ${info} not found.`, null);
        const user = results[0];
        return callback(null, user);
    });
}

function user_mail_exist(mail, callback) {
    db.execute('SELECT id, email, name, firstname, created_at FROM user WHERE email = ?', [mail], (err, results) => {
        if (results.length == 0)
          return callback(false);
        return callback(true);
    });
}

function user_id_exist(id, callback) {
  db.execute(
      'SELECT id, email, name, firstname, created_at FROM user WHERE id = ?',
      [id],
      (err, results) => {
        if (results.length == 0) {
          return callback(false);
        }
        return callback(true);
      }
    );
}
module.exports = {get_user_by_id, get_user_by_email, get_all_user_informations, get_user_todos, create_user, update_user, delete_user, get_user_by_info, user_mail_exist, user_id_exist};
