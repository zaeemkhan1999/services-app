const express = require("express");
const { check, validationResult } = require("express-validator");
const router = express.Router();
const bcrypt = require("bcryptjs");
const Clinet = require("../models/Client");
const User = require("../models/user");

router.post(
  "/",
  [
    check("fullName", "Name is required").not().isEmpty(),
    check("phone", "phone is required").not().isEmpty(),
    check("city", "city is required").not().isEmpty(),
    check("zone", "zone is required").not().isEmpty(),
    check("location", "location is required").not().isEmpty(),
    check("password", "Please enter a password with 6 or more characters")
      .not()
      .isEmpty(),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ success: false, error: errors.array() });
    }
    const {
      fullName,
      email,
      password,
      phone,
      city,
      zone,
      location,
      profileImage,
      metadata,
    } = req.body;
    try {
      let user = await User.findOne({ email });

      if (user) {
        return res
          .status(400)
          .json({ success: false, error: "user already exsits" });
      }
      user = new User({
        email,
        password,
        role: "client",
      });

      const salt = await bcrypt.genSalt(10);
      user.password = await bcrypt.hash(password, salt);
      const newUser = await user.save();
      let client = new Clinet({
        fullName,
        phone,
        city,
        zone,
        location,
        profileImage,
        metadata,
        user_id: newUser._id,
      });
      const newclient = await client.save();

      return res.json({
        success: true,
        createdUser: {
          client_id: newclient._id,
          user_id: newUser._id,
          fullname: newclient.fullName,
        },
      });
    } catch (err) {
      return res.status(500).json({ success: false, error: err.message });
    }
  }
);

router.get("/:id", async (req, res) => {
  try {
    let foundUser = await Clinet.findById(req.params.id);
    if (foundUser) {
      return res.json({
        success: true,
        Clinet: foundUser,
      });
    } else {
      return res.status(404).json({ success: false, error: "User Not Found" });
    }
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/", async (req, res) => {
  try {
    let allUsers = await Clinet.find().populate("user_id");
    return res.json({
      success: true,
      Clinet: allUsers,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

module.exports = router;
