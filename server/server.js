const express = require('express')
const mongoose = require('mongoose')

require('dotenv').config();
const app = express()

mongoose.connect(process.env.MONGODB_LINK);

const PORT = '3010'
app.listen(PORT, (req, res) => {
    console.log("Server started on port " + PORT)
})