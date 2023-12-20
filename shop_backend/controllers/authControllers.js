const User = require("../models/User");

const CryptoJS = require('crypto-js');
const jwt = require("jsonwebtoken");

module.exports = {
    createUser: async(req, res)=> {
        const newUser = new User({
            username: req.body.username,
            email: req.body.email,
            password: CryptoJS.AES.encrypt(req.body.password, process.env.SECRET).toString(),
            location: req.body.location,
        });
        try {
            await newUser.save();

            res.status(201).json({message: "User successfully created"})
        } catch (error) {
            res.status(500).json({message: error})
        }
    },
    loginUser: async(req, res)=> {
        try {
            const user = await User.find({email: req.body.email})
            !user && res.status(401).json("could not find the user")

            const decryptedpass = CryptoJS.AES.decrypt(user.password, )
        } catch (error) {
            
        }
    },
}