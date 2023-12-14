const mongoose = require("mongoose");


const CartSchema = new mongoose.Schema({
    name: {type: String, required: true},
    title: {type: String, required: true},
    category: {type: String, required: true},
    imageUrl: {type: [String], required: true},
    oldPrice: {type: String, required: true},
    price: {type: String, required: true},
    description: {type: String, required: true}
},{timestamps: true});

module.exports = mongoose.model("Cart", ProductSchema)