const express = require("express");
const { check, validationResult } = require("express-validator");
const router = express.Router();
const bcrypt = require("bcryptjs");
const Worker = require("../models/worker");
const User = require("../models/user");
const Service = require("../models/services");
const ServiceDetails = require("../models/serviceDetails");

router.post(
  "/",
  [
    check("fullName", "Name is required").not().isEmpty(),
    check("email", "email is required").not().isEmpty(),
    check("phone", "phone is required").not().isEmpty(),
    check("city", "city is required").not().isEmpty(),
    check("zone", "zone is required").not().isEmpty(),
    check("professionTitle", "professionTitle is required").not().isEmpty(),
    check("Skills", "Skills is required").not().isEmpty(),
    check("WorkExperiance", "WorkExperiance is required").not().isEmpty(),
    check("BaseRate", "BaseRate is required").not().isEmpty(),
    check("Dis", "Dis is required").not().isEmpty(),
    check("Service_id", "Service_id is required").not().isEmpty(),
    check("password", "Please enter a password with 6 or more characters")
      .not()
      .isEmpty(),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ success: false, error: errors.array() });
    }
    const {
      fullName,
      email,
      password,
      phone,
      city,
      zone,
      location,
      profileImage,
      cnic_picture,
      Skills,
      WorkExperiance,
      BaseRate,
      Recording,
      Dis,
      Service_id,
      metadata,
      professionTitle,
    } = req.body;
    try {
      let user = await User.findOne({ email });

      if (user) {
        return res
          .status(400)
          .json({ success: false, error: "user already exsits" });
      }
      user = new User({
        email,
        role: "worker",
      });

      const salt = await bcrypt.genSalt(10);
      user.password = await bcrypt.hash(password, salt);
      const newUser = await user.save();
      //
      let serviceDetails = new ServiceDetails({
        Skills,
        WorkExperiance,
        BaseRate,
        Recording,
        Dis,
        metadata,
        Service: Service_id,
      });
      await serviceDetails.save();
      let worker = new Worker({
        fullName,
        phone,
        city,
        zone,
        location,
        professionTitle,
        profileImage,
        cnic_picture,
        rating: "0",
        metadata,
        user_id: newUser._id,
        ServiceDetails: serviceDetails._id,
      });
      const newWorker = await worker.save();

      return res.json({
        success: true,
        createdUser: {
          Worker_id: newWorker._id,
          user_id: newUser._id,
          fullname: newWorker.fullName,
        },
      });
    } catch (err) {
      return res.status(500).json({ success: false, error: err.message });
    }
  }
);
router.post("/update/:id", async (req, res) => {
  const {
    profileImage,
    cnic_picture,
    Skills,
    WorkExperiance,
    BaseRate,
    Recording,
    Dis,
    Service_id,
    professionTitle,
  } = req.body;
  try {
    var worker = await Worker.findById(req.params.id);

    var service_detail = await ServiceDetails.findById(worker.ServiceDetails);

    if (professionTitle != null) {
      service_detail.professionTitle = professionTitle;
    }
    if (Dis != null) {
      service_detail.Dis = Dis;
    }
    if (Service_id != null) {
      service_detail.Service_id = Service_id;
    }
    if (BaseRate != null) {
      service_detail.BaseRate = BaseRate;
    }
    if (WorkExperiance != null) {
      service_detail.WorkExperiance = WorkExperiance;
    }
    if (profileImage != null) {
      worker.profileImage = profileImage;
    }
    if (cnic_picture != null) {
      worker.cnic_picture = cnic_picture;
    }
    if (Skills != null) {
      service_detail.Skills = Skills;
    }
    if (Recording != null) {
      service_detail.Recording = Recording;
    }

    await worker.save();
    await service_detail.save();
    return res.json({
      success: true,
      msg: "UPDATED",
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});
router.get("/:id", async (req, res) => {
  try {
    let foundUser = await Worker.findById(req.params.id)
      .populate("ServiceDetails")
      .populate("user_id")
      .exec();
    if (foundUser) {
      return res.json({
        success: true,
        Worker: foundUser,
      });
    } else {
      return res.status(404).json({ success: false, error: "User Not Found" });
    }
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/profId/all/:id", async (req, res) => {
  try {
    let foundUser = await Worker.find()
      .populate("ServiceDetails")
      .populate("user_id")
      .exec();

    var selected = [];
    foundUser.forEach((e) => {
      if (e.ServiceDetails.Service == req.params.id) {
        selected.push(e);
      }
    });

    return res.json({
      success: true,
      Worker: selected,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/", async (req, res) => {
  try {
    let allUsers = await Worker.find()
      .populate("ServiceDetails")
      .populate("user_id")
      .exec();
    return res.json({
      success: true,
      Worker: allUsers,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/ranting/district/:id/:prf", async (req, res) => {
  try {
    let allUsers = await Worker.find()
      .sort({ rating: -1 })
      .populate("ServiceDetails");
    var count = 0;
    var filter = [];
    allUsers.forEach((e) => {
      if (e["ServiceDetails"]["Service"] == req.params.prf) {
        filter.push(e);
      }
    });
    for (let i = 0; i < filter.length; i++) {
      if (filter[i].id == req.params.id) {
        count = i + 1;
      }
    }
    return res.json({
      success: true,
      count: count,
      filter,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.post("/service/create", async (req, res) => {
  try {
    let service = new Service({
      ServiceDomain: req.body.ServiceDomain,
      ServiceTitle: req.body.ServiceTitle,
      ServiceDis: req.body.ServiceDis,
      metadata: req.body.metadata,
    });
    await service.save();
    return res.json({
      success: true,
      msg: "CREATED",
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/service/get", async (req, res) => {
  try {
    let services = await Service.find();
    return res.json({
      success: true,
      services: services,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/get-by-log-lat/:log/:lat", async (req, res) => {
  try {
    let allUsers = await Worker.find({
      location: {
        log: req.params.log,
        lat: req.params.lat,
      },
    })
      .populate("ServiceDetails")
      .populate("user_id")
      .exec();
    return res.json({
      success: true,
      Worker: allUsers,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

module.exports = router;
