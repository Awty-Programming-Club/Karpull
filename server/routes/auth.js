const express = require('express')
const actions = require('../methods/actions')
const router = express.Router()

router.post("/create-user", actions.addNew)
router.post("/signin", actions.signIn)

router.get("/getinfo", actions.AuthCheck, (req, res) => {
    console.log("HELLO", req.user)
    res.sendStatus(200)
})

module.exports = router