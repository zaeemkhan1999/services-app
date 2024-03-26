import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opusapp/screens/StartScreen.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/home/GridMenuScreen.dart';
import 'package:opusapp/screens/home/NotificationScreen.dart';
import 'package:opusapp/screens/login-signup/LoginScreen.dart';
import 'package:opusapp/screens/login-signup/NoInternetScreen.dart';
import 'package:opusapp/screens/login-signup/SignUpScreen.dart';
import 'package:opusapp/screens/home/MenuScreen.dart';
import 'package:opusapp/screens/services/MapScreen.dart';
import 'package:opusapp/screens/services/Service.dart';
import 'package:opusapp/screens/services/WorkerDetails.dart';
import 'package:opusapp/screens/status/WorkerStatus.dart';
import 'package:opusapp/screens/worker/BookingsListWorker.dart';
import 'package:opusapp/screens/worker/WorkerMenuScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'OPUS',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: SColors.PrimaryColorPurple),
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}
