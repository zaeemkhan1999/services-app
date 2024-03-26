const jwt = require("jsonwebtoken");

module.exports = function (req, res, next) {
  const token = req.header("x-auth-token");
  if (!token) {
    return res.status(401).json({ msg: "No token , authorization denied" });
  }
  try {
    const decoded = jwt.verify(token, "QWERTY");
    req.varifiedUser = decoded;
    next();
  } catch (err) {
    res.send(401).json({ msg: "Token is not valid" });
  }
};
