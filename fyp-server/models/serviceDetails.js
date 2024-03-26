const mongoose = require("mongoose");

const ServiceDetailsSchema = new mongoose.Schema(
  {
    Service: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "services",
    },
    Skills: {
      type: JSON,
    },
    WorkExperiance: {
      type: String,
    },
    BaseRate: {
      type: String,
    },
    Recording: {
      type: JSON,
    },
    Dis: {
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

module.exports = ServiceDetails = mongoose.model(
  "serviceDetails",
  ServiceDetailsSchema
);
