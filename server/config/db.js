const mongoose = require('mongoose')
require('dotenv').config()

const connectDB = async() => {
    try {
        const conn = await mongoose.connect(process.env.MONGODB_LINK, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        })
        console.log(`MongoDB Connected: ${conn.connection.host}`)
    }
    catch(err) {
        console.log(err)
        process.exit(1)
    }
}

module.exports = connectDB