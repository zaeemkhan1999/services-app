import 'package:flutter/material.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/home/MenuScreen.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/services/Lists.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:opusapp/utils/Http-Service.dart';

class FeedBackPopUps extends StatefulWidget {
  var name;
  var book;
  FeedBackPopUps({@required this.name, @required this.book});
  @override
  _FeedBackPopUpsState createState() => _FeedBackPopUpsState();
}

class _FeedBackPopUpsState extends State<FeedBackPopUps> {
  final feedbackController = TextEditingController();
  var rating = 0.0;
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
                      children: [
                        Text(
                          "Feedback",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: ScreenSizeConfig.safeBlockHorizontal * 6,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              ScreenSizeConfig.safeBlockHorizontal * 5,
                              0,
                              ScreenSizeConfig.safeBlockHorizontal * 5,
                              0),
                          child: Container(
                            height: ScreenSizeConfig.safeBlockVertical * 10,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                controller: feedbackController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey[500],
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: 'I am..',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: RatingBar.builder(
                            initialRating: 0.5 * 5,
                            minRating: 0.0 * 5,
                            maxRating: 1.0 * 5,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: ScreenSizeConfig.safeBlockHorizontal * 10,
                            itemPadding: EdgeInsets.symmetric(
                                horizontal:
                                    ScreenSizeConfig.safeBlockHorizontal * 0.5),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (r) {
                              this.rating = r;
                            },
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Rate Booking',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                fontSize:
                                    ScreenSizeConfig.safeBlockHorizontal * 6,
                              ),
                            ))
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                            var feedback = {
                              "feedback": this.feedbackController.text,
                              "rating": this.rating.toString(),
                              "booking": widget.book["_id"],
                              "worker": widget.book["Worker"]["_id"],
                              "client": widget.book["Client"]["_id"]
                            };
                            var resp = await ApiHandler().makePutRequest(
                                "/booking/book/completed/${widget.book["_id"]}",
                                feedback);
                            if (resp != null) {
                              Navigator.pushAndRemoveUntil<void>(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        MenuScreen()),
                                ModalRoute.withName('/'),
                              );
                            }
                            print(resp);
                          },
                          child: Text(
                            'End Booking ',
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
