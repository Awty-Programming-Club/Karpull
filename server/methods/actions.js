const User = require('../models/user')
const jwt = require('jwt-simple')

const functions = {
    addNew: function (req, res) {
        if((!req.body.name) || (!req.body.password) || (!req.body.confirm)) {
            return res.json({success: false, msg: 'Enter all fields'})
        }
        if(req.body.password != req.body.confirm){
            return res.json({success: false, msg: "Password and confirm don't match"})
        }
        const newUser = User({
            name: req.body.name,
            username: req.body.username,
            password: req.body.password
        })
        newUser.save(function (err, newUser) {
            if(err) {
                return res.json({success: false, msg: 'Failed to save'})
            }
            return res.json({success: true, msg: 'Successfully saved'})
        })
    },
    signIn: function (req, res) {
        User.findOne({
            name: req.body.name
        }, function (err, user) {
            if (err) throw err
            if (!user) {
                return res.status(403).send({success: false, msg: 'Authentification Failed, User not found'})
            }
            user.comparePassword(req.body.password, function (err, isMatch) {
                if (isMatch && !err) {
                    const token = jwt.encode(user, process.env.SECRET)
                    res.json({success: true, token: token})
                }
                else {
                    return res.status(403).send({success: false, msg: 'Authentification failed, wrong password'})
                }
            })
        })
    }
}

module.exports = functions