import 'package:flutter/material.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SColors.PrimaryColorPurple,
      body: Center(
        child: Container(
          height: ScreenSizeConfig.safeBlockVertical * 40,
          width: ScreenSizeConfig.safeBlockHorizontal * 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Center(
              child: Text(
            'No Internet Connection',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: ScreenSizeConfig.safeBlockHorizontal * 6,
            ),
          )),
        ),
      ),
    );
  }
}
