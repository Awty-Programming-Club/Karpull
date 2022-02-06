const User = require('../models/user')
const jwt = require('jwt-simple')
const passport = require('passport')

const functions = {
    addNew: function (req, res) {
        if((!req.body.name) || (!req.body.username) || (!req.body.password) || (!req.body.confirm)) {
        // if((!req.body.name) || (!req.body.username) || (!req.body.password) || (!req.body.confirm) || (req.body.puller != (false || true))) {
            return res.status(406).json({success: false, msg: 'Enter all fields'})
        }
        if(req.body.password != req.body.confirm){
            return res.status(406).json({success: false, msg: "Password and confirm don't match"})
        }

        const newUser = User({
            name: req.body.name,
            username: req.body.username,
            password: req.body.password,
            puller: false
        })
        newUser.save(function (err, newUser) {
            if(err) {
                return res.status(406).json({success: false, msg: 'Failed to save'})
            }
            return res.status(200).json({success: true, msg: 'Successfully saved'})
        })
    },

    signIn: function (req, res) {
        User.findOne({
            username: req.body.username
        }, function (err, user) {
            if (err) throw err
            if (!user) {
                return res.status(403).send({success: false, msg: 'Authentification Failed, User not found'})
            }
            user.comparePassword(req.body.password, function (err, isMatch) {
                if (isMatch && !err) {
                    const token = jwt.encode(user, process.env.SECRET)
                    return res.json({success: true, token: token})
                }
                return res.status(403).send({success: false, msg: 'Authentification failed, wrong password'})
            })
        })
    },

    AuthCheck: function (req) {
        if(req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer'){
            const token = req.headers.authorization.split(' ')[1]
            const decodedtoken = jwt.decode(token, process.env.SECRET)
            return decodedtoken
        }
        return false
    }
    // getInfo: function(req, res) {
    //     if(req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer'){
    //         const token = req.headers.authorization.split(' ')[1]
    //         const decodedtoken = jwt.decode(token, process.env.SECRET)
    //         return res.json({success: true, msg: 'Hello ' + decodedtoken.name})
    //     }
    //     return res.json({success: false, msg: 'No Headers'})
    // }

}

module.exports = functions