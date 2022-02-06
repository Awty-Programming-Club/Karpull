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

    var R = 6371;

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

router.get('/', async (req, res) => {
    const checkuser = actions.AuthCheck(req)
    if(!checkuser) return res.sendStatus(403)
    const user = await User.findById(checkuser._id)
    if(!user) return res.sendStatus(403)
    res.status(200).json(user);
});

router.post('/set-partner', async (req, res) => {
    const checkuser = actions.AuthCheck(req)
    if(!checkuser) return res.sendStatus(403)
    const user = await User.findById(checkuser._id)
    if(!user) return res.sendStatus(403)
    if (user.puller === false) return res.sendStatus(401);
    
    const username = req.body.username;
    const pulledUser = await User.findOne({username: username});
    if(!pulledUser) return res.status(404);

    if(pulledUser.partner) return res.status(403);
    
    user.partner = pulledUser._id.toString();
    pulledUser.partner = user._id.toString();

    await user.save();
    await pulledUser.save();   
    return res.status(200); 
})

router.post("/update-location", async (req, res) => {
    const checkuser = actions.AuthCheck(req)
    if(!checkuser) return res.sendStatus(403)
    const user = await User.findById(checkuser._id)
    if(!user) return res.sendStatus(403)

    if((!req.body.latitude) || (!req.body.longitude)) return res.status(406).send("Missing latitude or longitude")
    if(req.body.latitude != user.latitude && req.body.longitude != user.longitude){
        user.latitude = req.body.latitude
        user.longitude = req.body.longitude
        await user.save()
    }

    if(!user.partner) return res.sendStatus(406)

    if(user.puller === false) return res.status(200).json({here: user.here, distance: user.distance})
    
    const pulledUser = await User.findById(user.partner)
    if (!pulledUser) return res.sendStatus(404)
    if ((!pulledUser.latitude) || (!pulledUser.longitude)) return res.status(404).send("latitude or longitude not found for pulled user")

    const pullerCoordinates = {
        latitude: user.latitude,
        longitude: user.longitude
    }
    const pulledCoordinates = {
        latitude: pulledUser.latitude,
        longitude: pulledUser.longitude
    }

    const distance = distanceBetweenCoordinates(pullerCoordinates, pulledCoordinates)
    user.here = distance<=50
    user.distance = distance
    pulledUser.here = distance<=50
    pulledUser.distance = distance
    await user.save()
    await pulledUser.save()
    return res.status(200).json({here: (distance<=50), distance: distance})
})

module.exports = router