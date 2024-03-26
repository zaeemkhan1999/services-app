import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/login-signup/shared/STextField.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:opusapp/utils/Http-Service.dart';
import 'package:opusapp/utils/local-storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class UpdateProfileCreate extends StatefulWidget {
  @override
  _UpdateProfileCreateState createState() => _UpdateProfileCreateState();
}

class _UpdateProfileCreateState extends State<UpdateProfileCreate> {
  final professionTitle = TextEditingController();
  final skills = TextEditingController();
  final baseRate = TextEditingController();
  final workExp = TextEditingController();
  final about = TextEditingController();

  var _pickedImageProfile;
  var _pickedImageCNIC;
  String dropdownValue = 'Carpenter';
  String professsionSelected = "";

  var decodedBytesl;
  var decodedBytes;

  var check_option = false;
  final _picker = ImagePicker();
  var services = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServices().then((e) {
      setState(() {});
    });
    getworkers().then((e){
      setState((){});
    });
  }

  var worker;
  getworkers() async {
    var resp = await ApiHandler()
        .makeGetRequest("/worker/${Storage.getValue("worker_id")}");
    worker = resp.data["Worker"];
  }

  getServices() async {
    services = (await ApiHandler().makeGetRequest("/worker/service/get"))
        .data["services"];
    print(services);
  }

  void _pickImageProfile() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallery"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imageSource != null) {
      final file =
          // ignore: deprecated_member_use
          io.File((await _picker.getImage(source: imageSource, imageQuality: 2))
              .path);
      if (file != null) {
        setState(() => _pickedImageProfile = file);
      }
    }
  }

  void _pickImageCNIC() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallery"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imageSource != null) {
      final file =
          // ignore: deprecated_member_use
          io.File((await _picker.getImage(source: imageSource, imageQuality: 2))
              .path);
      if (file != null) {
        setState(() => _pickedImageCNIC = file);
      }
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.services.length == 0 || this.worker == null
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
                                  await this._pickImageProfile();
                                },
                                child: Container(
                                    child: Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        child: this._pickedImageProfile == null
                                            ? this.worker["profileImage"] == null ? Image.asset(
                                                "assets/images/default-dp.png"): Image.memory(base64Decode(
                                                worker["profileImage"]))
                                            : Image.file(_pickedImageProfile))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(worker["fullName"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      Text(
                                        "UPDATE PROFILE PICTURE",
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      )
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
                              STextField(
                                  title: 'professionTitle ',
                                  hint: 'Carpenter',
                                  obscureField: false,
                                  thisController: professionTitle),
                              STextField(
                                  title: 'Skills ',
                                  hint: 'What you do best',
                                  obscureField: false,
                                  thisController: skills),
                              Container(
                                //width: 100,
                                child: Row(
                                  children: [
                                    Container(
                                      width: ScreenSizeConfig.screenWidth * 0.4,
                                      height:
                                          ScreenSizeConfig.screenHeight * 0.14,
                                      child: STextField(
                                          title: 'Base Rate ',
                                          hint: '500 RS',
                                          obscureField: false,
                                          thisController: baseRate),
                                    ),
                                    Container(
                                      width: ScreenSizeConfig.screenWidth * 0.4,
                                      height:
                                          ScreenSizeConfig.screenHeight * 0.14,
                                      child: STextField(
                                          title: 'WorkExperiance ',
                                          hint: '0-5 years',
                                          obscureField: false,
                                          thisController: workExp),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: ScreenSizeConfig.screenWidth * 1,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            child: Text(
                                          "Select Profession",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                        // Padding(
                                        //   padding: EdgeInsets.only(left: 12.0),
                                        Container(
                                          // width:
                                          //     ScreenSizeConfig.screenWidth *
                                          //         0.3,
                                          child: DropdownButton(
                                            value: dropdownValue,
                                            icon: Icon(Icons.arrow_downward),
                                            iconSize: 24,
                                            elevation: 16,
                                            style: TextStyle(
                                                color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (newValue) {
                                              services.forEach((element) {
                                                if (element["ServiceDomain"] ==
                                                    newValue) {
                                                  this.professsionSelected =
                                                      element["_id"];
                                                }
                                              });
                                              setState(() {
                                                dropdownValue = newValue;
                                              });
                                            },
                                            items: services
                                                .map<DropdownMenuItem>((value) {
                                              return DropdownMenuItem<String>(
                                                value: value["ServiceDomain"],
                                                child: Text(
                                                    value["ServiceDomain"]),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: ScreenSizeConfig.screenWidth * 0.4,
                                      height:
                                          ScreenSizeConfig.screenHeight * 0.1,
                                      child: STextField(
                                          title: 'About ',
                                          hint: '',
                                          obscureField: false,
                                          thisController: about),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        Map<Permission, PermissionStatus>
                                            statuses = await [
                                          Permission.storage,
                                          Permission.microphone
                                        ].request();
                                        this.check_option = !check_option;

                                        bool hasPermission =
                                            await FlutterAudioRecorder
                                                .hasPermissions;
                                        var appDocDirectory = await ExtStorage
                                            .getExternalStoragePublicDirectory(
                                                ExtStorage.DIRECTORY_DOWNLOADS);

                                        print(hasPermission);
                                        var path =
                                            await _localPath + "/recording1";

                                        var recorder = FlutterAudioRecorder(
                                            path,
                                            sampleRate:
                                                22000); // sampleRate is 16000 by default
                                        await recorder.initialized;

                                        if (check_option) {
                                          await recorder.start();
                                        } else {
                                          await recorder.stop();
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right:
                                                ScreenSizeConfig.screenWidth *
                                                    0.08),
                                        child: Container(
                                          width: ScreenSizeConfig.screenWidth *
                                              0.34,
                                          height:
                                              ScreenSizeConfig.screenHeight *
                                                  0.043,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Icon(
                                                    Icons.audiotrack_rounded,
                                                    color: SColors
                                                        .PrimaryColorPurple),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Icon(
                                                    this.check_option
                                                        ? Icons.play_arrow
                                                        : Icons.stop,
                                                    color: SColors
                                                        .PrimaryColorPurple),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: ScreenSizeConfig.screenWidth * 1,
                                height: ScreenSizeConfig.screenHeight * 0.06,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenSizeConfig.screenWidth *
                                              0.25),
                                      child: Center(
                                        child: Container(
                                            width:
                                                ScreenSizeConfig.screenWidth *
                                                    0.5,
                                            height:
                                                ScreenSizeConfig.screenHeight *
                                                    0.06,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    await this._pickImageCNIC();
                                                  },
                                                  child: Text(
                                                    "CNIC PICTURE   ",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                Container(
                                                    height: ScreenSizeConfig
                                                            .screenHeight *
                                                        0.03,
                                                    child: Container(
                                                        height: 10,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        30))),
                                                        child: this._pickedImageCNIC ==
                                                                null
                                                            ? Image.asset(
                                                                "assets/images/default-dp.png")
                                                            : Image.file(this
                                                                ._pickedImageCNIC))),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Container(
                                  width: ScreenSizeConfig.screenWidth * 1,
                                  height: ScreenSizeConfig.screenHeight * 0.06,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: ScreenSizeConfig.screenWidth *
                                              0.5,
                                          height:
                                              ScreenSizeConfig.screenHeight *
                                                  0.06,
                                          child: TextButton(
                                              onPressed: () async {
                                                var path = await _localPath;
                                                var openfile = io.File(
                                                    '$path/recording1.m4a');
                                                print(openfile);
                                                final bytes = await openfile
                                                    .readAsBytes();

                                                String base64File =
                                                    base64Encode(bytes);
                                                print(base64File);

                                                //converted cnic to base64 profileImage
                                                String profilepic;
                                                String nicpic;
                                                if (_pickedImageProfile !=
                                                    null) {
                                                  profilepic = base64Encode(
                                                      await this
                                                          ._pickedImageProfile
                                                          .readAsBytes());
                                                }
                                                if (_pickedImageCNIC != null) {
                                                  nicpic = base64Encode(
                                                      await this
                                                          ._pickedImageCNIC
                                                          .readAsBytes());
                                                }
                                                print(nicpic);
                                                var worker = {
                                                  "professionTitle":
                                                      this.professionTitle.text,
                                                  "Skills": this.skills.text,
                                                  "WorkExperiance":
                                                      this.workExp.text,
                                                  "BaseRate":
                                                      this.baseRate.text,
                                                  "Recording": base64File,
                                                  "Dis": this.about.text,
                                                  "Service_id":
                                                      this.professsionSelected,
                                                  "cnic_picture": nicpic,
                                                  "profileImage": profilepic
                                                };
                                                print(worker);

                                                var resp = await ApiHandler()
                                                    .makePostRequest(
                                                        "/worker", worker);
                                                print(resp.data);
                                                if (resp.data != null) {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Text(
                                                'Update Profile',
                                                style: TextStyle(
                                                    color: SColors
                                                        .PrimaryColorPurple),
                                              ),
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                          side: BorderSide(
                                                              color: SColors
                                                                  .PrimaryColorPurple))))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
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
