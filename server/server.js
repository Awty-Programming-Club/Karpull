const express = require('express')
const mongoose = require('mongoose')
const cors = require('cors')
const passport = require('passport')
const connectDB = require('./config/db')

require('dotenv').config()
const user = require('./routes/user')
const app = express()

connectDB()

app.use(express.urlencoded({extended: false}))

app.use("/user", user)

const PORT = process.env.PORT || 3010
app.listen(PORT, (req, res) => {
    console.log(`Server started on port ${PORT}`)
})