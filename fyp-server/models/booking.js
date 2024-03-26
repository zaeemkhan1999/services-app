const mongoose = require("mongoose");

const BookingSchema = new mongoose.Schema(
  {
    Client: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "client",
    },
    Worker: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "worker",
    },
    status: {
      type: String,
    },
    status_val: {
      type: String,
    },
    booking_task: {
      type: String,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = Booking = mongoose.model("booking", BookingSchema);
