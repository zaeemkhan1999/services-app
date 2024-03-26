import 'package:flutter/material.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/services/BookingScreen.dart';
import 'package:opusapp/screens/services/Lists.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:opusapp/utils/Http-Service.dart';
import 'package:opusapp/utils/local-storage.dart';
import 'package:opusapp/screens/login-signup/shared/STextField.dart';

class BookingsPopUp extends StatefulWidget {
  var worker;
  var name;
  BookingsPopUp({@required this.name, @required this.worker});
  @override
  _BookingsPopUpState createState() => _BookingsPopUpState();
}

class _BookingsPopUpState extends State<BookingsPopUp> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.8,
            child: Container(
              color: SColors.PrimaryColorPurple,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    alignment: AlignmentDirectional.center,
                    height: ScreenSizeConfig.safeBlockVertical * 40,
                    width: ScreenSizeConfig.safeBlockHorizontal * 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Confirm Booking with " + widget.name + "?",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: ScreenSizeConfig.safeBlockHorizontal * 6,
                          ),
                        ),
                        STextField(
                            title: ' ',
                            hint: null,
                            obscureField: false,
                            thisController: textController),
                      ],
                    ))),
          ),
          Container(
              alignment: AlignmentDirectional.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 2),
                    child: Container(
                      padding: EdgeInsets.all(
                          ScreenSizeConfig.safeBlockHorizontal * 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      height: ScreenSizeConfig.safeBlockVertical * 10,
                      width: ScreenSizeConfig.safeBlockHorizontal * 15,
                      child: TextButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 2),
                    child: Container(
                      padding: EdgeInsets.all(
                          ScreenSizeConfig.safeBlockHorizontal * 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      height: ScreenSizeConfig.safeBlockVertical * 10,
                      width: ScreenSizeConfig.safeBlockHorizontal * 60,
                      child: TextButton(
                          onPressed: () async {
                            //book now
                            var book = {
                              "worker_id": widget.worker.id,
                              "client_id": Storage.getValue("worker_id")
                            };
                            await ApiHandler()
                                .makePostRequest("/booking/book", book);
                            print(book);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingScreen(
                                        name: widget.name,
                                        worker: widget.worker,
                                      )),
                            );
                          },
                          child: Text(
                            'BOOK NOW!',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize:
                                  ScreenSizeConfig.safeBlockHorizontal * 6,
                            ),
                          )),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
