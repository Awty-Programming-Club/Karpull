const express = require('express')
const mongoose = require('mongoose')
const cors = require('cors')
const passport = require('passport')
const connectDB = require('./config/db')
const session  = require('express-session')

require('dotenv').config()
const user = require('./routes/user')
const auth = require('./routes/auth')
const app = express()

connectDB()

app.use(cors())
app.use(express.urlencoded({extended: false}))
app.use(express.json())

app.use(passport.initialize())
require('./config/passport')(passport)

app.use("/auth", auth)
app.use("/user", user)

const PORT = process.env.PORT || 3010
app.listen(PORT, (req, res) => {
    console.log(`Server started on port ${PORT}`)
})