const mongoose = require("mongoose");

const FeedbackSchema = new mongoose.Schema(
  {
    client: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "client",
    },
    worker: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "worker",
    },
    feedback: {
      type: String,
    },
    rating: {
      type: String,
    },
    booking: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "booking",
    },
  },
  {
    timestamps: true,
  }
);

module.exports = Feedback = mongoose.model("feedback", FeedbackSchema);
