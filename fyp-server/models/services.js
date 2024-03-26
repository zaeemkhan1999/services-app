const mongoose = require("mongoose");

const ServicesSchema = new mongoose.Schema(
  {
    ServiceDomain: {
      type: String,
    },
    ServiceTitle: {
      type: String,
    },
    ServiceDis: {
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

module.exports = Services = mongoose.model("services", ServicesSchema);
