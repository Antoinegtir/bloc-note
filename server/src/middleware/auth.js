const jwt = require('jsonwebtoken');
const user_id_exist = require('../routes/user/user.query').user_id_exist;

module.exports = (req, res, next) => {
    if (req.headers.authorization == null) {
        return res.status(500).json({ "msg": "No token given" });
    }
    const token = req.headers.authorization.split(" ")[1];
    if (!token)
        return res.status(500).json({ "msg": "No token given" });
    jwt.verify(token, process.env.SECRET, (err, decoded) => {
        if (err) return res.status(500).json({ "msg": "Invalid token" });
        const id = decoded.id;
        user_id_exist(id, (exists) => {
            if (!exists) return res.json({ "msg": "Error, user does not exist in db with this id" });
            req.middlewareId = id;
            next();
        });
    })
}
