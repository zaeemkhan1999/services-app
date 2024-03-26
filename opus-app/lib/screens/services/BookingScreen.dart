import 'package:flutter/material.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/services/Lists.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:opusapp/utils/Http-Service.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingScreen extends StatefulWidget {
  var name;
  var worker;
  BookingScreen({@required this.name, @required this.worker});
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Booked",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenSizeConfig.safeBlockHorizontal * 5),
        ),
        backgroundColor: SColors.PrimaryColorPurple,
        flexibleSpace: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: _inkwells(),
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenSizeConfig.safeBlockHorizontal * 10,
                  ScreenSizeConfig.safeBlockHorizontal * 10,
                  ScreenSizeConfig.safeBlockHorizontal * 10,
                  ScreenSizeConfig.safeBlockHorizontal * 10),
              child: Container(
                child: Center(
                  child: Container(
                      height: ScreenSizeConfig.safeBlockVertical * 20,
                      width: ScreenSizeConfig.safeBlockHorizontal * 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset('assets/images/people_icon.png')),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenSizeConfig.safeBlockHorizontal * 2),
              child: Container(
                padding:
                    EdgeInsets.all(ScreenSizeConfig.safeBlockHorizontal * 2),
                alignment: AlignmentDirectional.topCenter,
                height: ScreenSizeConfig.safeBlockVertical * 5,
                width: ScreenSizeConfig.safeBlockHorizontal * 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Your booking with ' + widget.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenSizeConfig.safeBlockHorizontal * 4,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenSizeConfig.safeBlockHorizontal * 2),
              child: Container(
                padding:
                    EdgeInsets.all(ScreenSizeConfig.safeBlockHorizontal * 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: SColors.PrimaryColorPurple,
                ),
                height: ScreenSizeConfig.safeBlockVertical * 10,
                width: ScreenSizeConfig.safeBlockHorizontal * 80,
                child: TextButton(
                    onPressed: () async {
                      var url = "tel://${widget.worker.phone}";

                      print(url);
                      await launch(url);
                    },
                    child: Text(
                      'Contact ' + widget.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenSizeConfig.safeBlockHorizontal * 6,
                      ),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenSizeConfig.safeBlockHorizontal * 2,
                  ScreenSizeConfig.safeBlockHorizontal * 10,
                  ScreenSizeConfig.safeBlockHorizontal * 2,
                  ScreenSizeConfig.safeBlockHorizontal * 2),
              child: Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: ScreenSizeConfig.safeBlockHorizontal * 40),
                      //   child: Container(
                      //     padding: EdgeInsets.all(
                      //         ScreenSizeConfig.safeBlockHorizontal * 2),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(100),
                      //       color: Colors.white,
                      //     ),
                      //     height: ScreenSizeConfig.safeBlockVertical * 10,
                      //     width: ScreenSizeConfig.safeBlockHorizontal * 15,
                      //     child: TextButton(
                      //       onPressed: () {},
                      //       child: Icon(
                      //         Icons.close,
                      //         color: Colors.red,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: ScreenSizeConfig.safeBlockHorizontal * 40),
                      //   child: Container(
                      //     padding: EdgeInsets.all(
                      //         ScreenSizeConfig.safeBlockHorizontal * 2),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       color: SColors.PrimaryColorPurple,
                      //     ),
                      //     height: ScreenSizeConfig.safeBlockVertical * 10,
                      //     width: ScreenSizeConfig.safeBlockHorizontal * 60,
                      //     child: TextButton(
                      //         onPressed: () {},
                      //         child: Text(
                      //           'End Booking ',
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize:
                      //                 ScreenSizeConfig.safeBlockHorizontal * 6,
                      //           ),
                      //         )),
                      //   ),
                      // ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _inkwells() {
    return Container(
      color: SColors.PrimaryColorPurple,
      child: Row(
        children: [
          Container(
            // width: ScreenSizeConfig.safeBlockHorizontal * 50,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenSizeConfig.safeBlockHorizontal * 5,
                  ScreenSizeConfig.safeBlockHorizontal * 6,
                  0,
                  0),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenSizeConfig.safeBlockHorizontal * 5, 0, 0),
                    child: Opacity(
                      opacity: 0.4,
                      child: Container(
                        height: ScreenSizeConfig.safeBlockVertical * 4.25,
                        width: ScreenSizeConfig.safeBlockHorizontal * 7.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: ScreenSizeConfig.safeBlockHorizontal * 6),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
