const express = require('express')
const actions = require('../methods/actions')
const router = express.Router()
const User = require('../models/user')

router.post("/update/location", async (req, res) => {
    const checkuser = actions.AuthCheck(req)
    if(!checkuser) return res.sendStatus(403)
    const user = await User.findById(checkuser._id)
    if(!user) return res.sendStatus(403)

    if((!req.body.latitude) || (!req.body.longitude)) return res.status(406).send("Missing latitude or longitude")
    if(req.body.latitude === user.latitude && req.body.longitude === user.longitude){
        user.latitude = req.body.latitude
        user.longitude = req.body.longitude
        await user.save()
    }

    if(!user.partner) return res.sendStatus(406)

    if(user.puller === false) return res.sendStatus(200)



    res.sendStatus(200)
})

module.exports = router