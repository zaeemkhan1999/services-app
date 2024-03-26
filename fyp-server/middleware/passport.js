const LocalStrategy = require("passport-local").Strategy;
const bcrypt = require("bcryptjs");
const User = require("../models/user");

module.exports = function (passport) {
  passport.use(
    new LocalStrategy(
      { usernameField: "email" },
      async (email, password, done) => {
        var user = await User.findOne({ email });
        if (!user)
          return done(null, false, { message: "That email not registered" });
        // matching password
        let isMatched = await bcrypt.compare(password, user.password);
        if (!isMatched) {
          return done(null, false, { message: "Invalid Password" });
        }
        return done(null, user);
      }
    )
  );
};
