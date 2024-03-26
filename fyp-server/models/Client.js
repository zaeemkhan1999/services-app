const mongoose = require("mongoose");

const ClientSchema = new mongoose.Schema(
  {
    fullName: {
      type: String,
    },
    user_id: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "user",
    },
    phone: {
      type: String,
    },
    city: {
      type: String,
    },
    zone: {
      type: String,
    },
    location: {
      type: JSON,
    },
    profileImage: {
      type: String,
    },
    metadata: {
      type: JSON,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = Client = mongoose.model("client", ClientSchema);
