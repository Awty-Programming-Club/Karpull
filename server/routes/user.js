const express = require('express')
const router = express.Router()

router.post("/update/location", (req, res) => {
    console.log(req.body)
    res.sendStatus(200)
})

module.exports = router