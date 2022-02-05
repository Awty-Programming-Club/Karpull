const express = require('express')
const actions = require('../methods/actions')
const router = express.Router()

router.post("/create-user", actions.addNew)
router.post("/signin", actions.signIn)

module.exports = router