const express = require('express')
const actions = require('../methods/actions')
const router = express.Router()

router.post("/update/location", (req, res) => {
    const user = actions.AuthCheck(req)
    if(!user) return res.sendStatus(403)
    res.json(user)
})

module.exports = router