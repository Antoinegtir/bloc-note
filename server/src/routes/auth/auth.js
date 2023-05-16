const express = require('express');
const router = express.Router();
const {get_user_by_email, create_user, user_mail_exist} = require('../user/user.query');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

router.post('/login', async (req, res, next) => {
    if (!req.body.email || !req.body.password)
      return res.status(400).json({ msg: "Bad parameter" });
    user_mail_exist(req.body.email, (exists) => {
        if (!exists) return res.status(409).json({msg : "Invalid Credentials"});
        get_user_by_email(req.body.email, (err, user) => {
            bcrypt.compare(req.body.password, user.password, (err, valid) => {
                if (valid) {
                    const expiresIn = 24 * 60 * 60;
                    const token = jwt.sign({id: user.id}, process.env.SECRET, {
                        expiresIn: expiresIn,
                    });
                    return res.status(200).json({token : token});
                } else {
                    return res.status(409).json({msg : "Invalid Credentials"});
                }
            });
        });
    });
});

router.post('/register', async (req, res, next) => {
  if (!req.body.email || !req.body.password || !req.body.name || !req.body.firstname)
      return res.status(400).json({ msg: "Bad parameter" });
  user_mail_exist(req.body.email, (exists) => {
    if (exists)
      return res.status(409).json({ msg: "Account already exists" });
    bcrypt.hash(req.body.password, 10, function(errhash, hash) {
        if (errhash)
          return res.status(500).json({ msg: "Internal server error" });
        create_user(req.body.email, hash, req.body.name, req.body.firstname, (code, newuser) => {
            const expiresIn = 24 * 60 * 60;
            const token = jwt.sign({id: newuser.id}, process.env.SECRET, {
                expiresIn: expiresIn,
            });
            return res.status(200).json({ token : token});
        })
    });  
  })
});

module.exports = router;
