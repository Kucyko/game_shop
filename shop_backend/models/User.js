const mongoose = require("mongoose");


const UserSchema = new mongoose.Schema({
    username: {type: String, required: true},
    email: {type: String, required: true, unique: true},
    password: {type: String, required: true},
    location: {type: String, dedfault: "Shenzhen China"},
    
},{timestamps: true});

module.exports = mongoose.model("User", ProductSchema)