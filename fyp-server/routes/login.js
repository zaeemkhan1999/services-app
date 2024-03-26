const express = require("express");
const { check, validationResult } = require("express-validator");
const router = express.Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const Worker = require("../models/worker");
const Client = require("../models/Client");
const passport = require("passport");

router.get("/", async (req, res) => res.send("User , route"));

//
router.post(
  "/",
  passport.authenticate("local", { session: false }),
  [
    check("email", "email is required").not().isEmpty(),
    check("password", "Password is required").not().isEmpty(),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ success: false, error: errors.array() });
    }
    try {
      console.log(req.user);
      if (req.user.role == "worker") {
        var authUser = await Worker.findOne({ user_id: req.user._id });
      } else {
        var authUser = await Client.findOne({ user_id: req.user._id });
      }

      // jwt token created
      let token = await jwt.sign(authUser.toJSON(), "QWERTY", {
        expiresIn: 36000000,
      });

      return res.json({
        user_id: req.user._id,
        user: authUser,
        worker_id: authUser.id,
        token: token,
        user_role: req.user.role,
      });
    } catch (err) {
      return res.status(500).json({ success: false, error: err });
    }
  }
);

module.exports = router;
