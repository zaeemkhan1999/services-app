const mongoose = require("mongoose");

const WorkerSchema = new mongoose.Schema(
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
    cnic_picture: {
      type: String,
    },
    location: {
      type: JSON,
    },
    ServiceDetails: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "serviceDetails",
    },
    rating: {
      type: String,
    },
    professionTitle: {
      type: String,
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

module.exports = Worker = mongoose.model("worker", WorkerSchema);
