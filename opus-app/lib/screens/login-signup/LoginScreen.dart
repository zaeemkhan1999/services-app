import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/home/GridMenuScreen.dart';
import 'package:opusapp/screens/home/MenuScreen.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/login-signup/shared/STextField.dart';
import 'package:opusapp/screens/login-signup/SignUpScreen.dart';
import 'package:opusapp/screens/worker/WorkerMenuScreen.dart';
import 'package:opusapp/utils/Http-Service.dart';
import 'package:opusapp/utils/local-storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                color: SColors.PrimaryColorPurple,
                height: ScreenSizeConfig.safeBlockVertical * 50,
                width: ScreenSizeConfig.safeBlockHorizontal * 100,
              ),
              Column(
                children: [
                  Container(
                    color: SColors.PrimaryColorPurple,
                    height: ScreenSizeConfig.safeBlockVertical * 7,
                    width: ScreenSizeConfig.safeBlockHorizontal * 100,
                  ),
                  Container(
                    color: SColors.PrimaryColorPurple,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: 0.6,
                            child: Container(
                              height: ScreenSizeConfig.safeBlockVertical * 4.25,
                              width: ScreenSizeConfig.safeBlockHorizontal * 7.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.keyboard_arrow_left,
                                  color: Colors.white,
                                  size: ScreenSizeConfig.safeBlockHorizontal *
                                      7.5),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: SColors.PrimaryColorPurple,
                    height: ScreenSizeConfig.safeBlockVertical * 10,
                    width: ScreenSizeConfig.safeBlockHorizontal * 100,
                  ),
                  Container(
                    height: ScreenSizeConfig.safeBlockVertical * 70,
                    width: ScreenSizeConfig.safeBlockHorizontal * 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(40.0),
                          bottomLeft: Radius.circular(0.0)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(
                                  ScreenSizeConfig.safeBlockHorizontal * 5,
                                  ScreenSizeConfig.safeBlockHorizontal * 7,
                                  0,
                                  0),
                              child: Text(
                                'Welcome Back',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            6),
                              )),
                          Container(
                              padding: EdgeInsets.fromLTRB(
                                  ScreenSizeConfig.safeBlockHorizontal * 5,
                                  ScreenSizeConfig.safeBlockHorizontal * 1.25,
                                  0,
                                  ScreenSizeConfig.safeBlockHorizontal * 5),
                              child: Text(
                                'Login to continue',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            3),
                              )),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  STextField(
                                      title: 'Email Address',
                                      hint: 'shahbaz@gmail.com',
                                      obscureField: false,
                                      thisController: emailController),
                                  STextField(
                                      title: 'Password',
                                      hint: null,
                                      obscureField: true,
                                      thisController: passwordController),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            5,
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            5,
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            5,
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            2),
                                    child: Container(
                                      height:
                                          ScreenSizeConfig.safeBlockVertical *
                                              8,
                                      width:
                                          ScreenSizeConfig.safeBlockHorizontal *
                                              90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: SColors.PrimaryColorPurple,
                                      ),
                                      child: TextButton(
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenSizeConfig
                                                        .safeBlockHorizontal *
                                                    4.5),
                                          ),
                                          onPressed: () async {
                                            try {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                var login = {
                                                  "email":
                                                      this.emailController.text,
                                                  "password": this
                                                      .passwordController
                                                      .text
                                                };
                                                print(login);
                                                Response resp =
                                                    await ApiHandler()
                                                        .makePostRequest(
                                                            "/login", login);

                                                print(resp.data["token"]);
                                                Storage.setValue("token",
                                                    resp.data["token"]);
                                                Storage.setValue("user_role",
                                                    resp.data["user_role"]);
                                                Storage.setValue("user_id",
                                                    resp.data["user_id"]);
                                                Storage.setValue("worker_id",
                                                    resp.data["worker_id"]);
                                                if (resp.statusCode == 401) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Incorrect email or password')));
                                                } else if (Storage.getValue(
                                                        "user_role") !=
                                                    "worker") {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MenuScreen()),
                                                  );
                                                } else {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            WorkerMenuScreen()),
                                                  );
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Field Missing Error')));
                                              }
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Incorrect email or password')));
                                            }
                                          }),
                                    ),
                                  ),
                                ],
                              )),

                          // Container(
                          //     alignment: Alignment.centerRight,
                          //     width: ScreenSizeConfig.safeBlockHorizontal * 100,
                          //     padding: EdgeInsets.fromLTRB(0, 0,
                          //         ScreenSizeConfig.safeBlockHorizontal * 5, 0),
                          //     child: TextButton(
                          //         onPressed: () {},
                          //         child: Text(
                          //           'Forgot Password?',
                          //           style: TextStyle(
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.bold,
                          //               fontSize: ScreenSizeConfig
                          //                       .safeBlockHorizontal *
                          //                   3),
                          //         ))),

                          // Container(
                          //     alignment: Alignment.center,
                          //     width: ScreenSizeConfig.safeBlockHorizontal * 100,
                          //     padding: EdgeInsets.fromLTRB(
                          //         ScreenSizeConfig.safeBlockHorizontal * 5,
                          //         ScreenSizeConfig.safeBlockHorizontal * 10,
                          //         0,
                          //         ScreenSizeConfig.safeBlockHorizontal * 5),
                          //     child: Text(
                          //       'Or Connect with',
                          //       style: TextStyle(
                          //           color: Colors.grey,
                          //           fontSize:
                          //               ScreenSizeConfig.safeBlockHorizontal *
                          //                   3),
                          //     )),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
