const mongoose = require("mongoose");

const NotificationSchema = new mongoose.Schema(
  {
    client: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "client",
    },
    worker: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "worker",
    },
    text: {
      type: String,
    },
    rating: {
      type: String,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = Notifications = mongoose.model(
  "notification",
  NotificationSchema
);
