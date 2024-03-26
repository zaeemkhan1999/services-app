import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/utils/Http-Service.dart';
import 'package:opusapp/utils/local-storage.dart';

class WorkerProfile extends StatefulWidget {
  WorkerProfile();
  @override
  _WorkerProfileState createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<WorkerProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWorkerbyId().then((e) {
      setState(() {});
    });
  }

  var worker;
  getWorkerbyId() async {
    worker = (await ApiHandler()
            .makeGetRequest("/worker/${Storage.getValue("worker_id")}"))
        .data["Worker"];
    print(worker);
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Scaffold(
      body: this.worker == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Stack(
              children: [
                Container(
                    height: 250,
                    color: SColors.PrimaryColorPurple,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: ScreenSizeConfig.screenHeight * 0.05,
                          left: ScreenSizeConfig.screenWidth * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  // await this._pickImageProfile();
                                },
                                child: Container(
                                    child: Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        child: worker["profileImage"] == null
                                            ? Image.asset(
                                                "assets/images/default-dp.png")
                                            : Image.memory(base64Decode(
                                                worker["profileImage"])))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(this.worker["fullName"],
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenSizeConfig.screenHeight * 0.24),
                  child: Center(
                    child: Container(
                        height: ScreenSizeConfig.screenHeight * 0.65,
                        width: ScreenSizeConfig.screenWidth * 0.92,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Name: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "    " + this.worker["fullName"],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Phone: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "    " + this.worker["phone"],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "City: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "    " + this.worker["city"],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Profession Title: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "    " + this.worker["professionTitle"],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Email: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "    " + this.worker["user_id"]["email"],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: ScreenSizeConfig
                                                .safeBlockHorizontal *
                                            3,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Work Experiance: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "    " +
                                          this.worker["ServiceDetails"]
                                              ["WorkExperiance"],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "About : ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "    " +
                                          this.worker["ServiceDetails"]["Dis"],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                )
              ],
            )),
    );
  }
}
