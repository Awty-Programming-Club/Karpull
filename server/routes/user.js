const express = require('express')
const actions = require('../methods/actions')
const router = express.Router()
const User = require('../models/user')

function distanceBetweenCoordinates(coordinate1, coordinate2){
    lat1 = coordinate1.latitude
    lon1 = coordinate1.longitude
    lat2 = coordinate2.latitude
    lon2 = coordinate2.longitude

    function toRad(x) {
        return x * Math.PI / 180;
    }

    var R = 6371; // km

    var x1 = lat2 - lat1;
    var dLat = toRad(x1);
    var x2 = lon2 - lon1;
    var dLon = toRad(x2)
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
    Math.sin(dLon / 2) * Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c;
    return d * 1000
}

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
    const pulledUser = await User.findById(user.partner)

    const pullerCoordinates = {
        latitude: user.latitude,
        longitude: user.longitude
    }
    const pulledCoordinates = {
        latitude: pulledUser.latitude,
        longitude: pulledUser.longitude
    }

    const distance = distanceBetweenCoordinates(pullerCoordinates, pulledCoordinates)
    return res.status(200).json({here: (distance<=50), distance: distance})
})

module.exports = router