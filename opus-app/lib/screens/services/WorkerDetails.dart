import 'dart:convert';
import 'dart:io' as io;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/services/PopUps/FeedBackPopUps.dart';
import 'package:opusapp/screens/services/PopUps/BookingsPopUp.dart';
import 'package:opusapp/screens/services/Lists.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:opusapp/utils/Http-Service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerDetails extends StatefulWidget {
  var jobTitle;
  var id;

  WorkerDetails({@required this.jobTitle, @required this.id});
  @override
  _WorkerDetailsState createState() => _WorkerDetailsState();
}

class _WorkerDetailsState extends State<WorkerDetails> {
  WorkerDetailsComplete workerDetailsComplete;

  List<Reviews> reviews = [
    Reviews(name: "Basit Jasani", rating: 0.8, details: "haha"),
    Reviews(name: "Basit Jasani", rating: 0.5, details: "hehe"),
  ];
  AudioPlayer audioPlayer = AudioPlayer();
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  var workerDetails;
  var recording_but = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllDetails().then((e) {
      setState(() {});
    });
  }

  getAllDetails() async {
    print("/worker/${widget.id}");
    var resp = await ApiHandler().makeGetRequest("/worker/${widget.id}");

    this.workerDetails = resp.data["Worker"];
    await getRanking(
        workerDetails["_id"], workerDetails["ServiceDetails"]["Service"]);
    workerDetailsComplete = new WorkerDetailsComplete(
      id: this.workerDetails["_id"],
      name: this.workerDetails["fullName"],
      phone: this.workerDetails["phone"],
      experience:
          '${workerDetails["ServiceDetails"]["WorkExperiance"]} Years experience',
      startingPrice: workerDetails["ServiceDetails"]["BaseRate"],
      rating: double.parse(workerDetails["rating"]),
      location: workerDetails["city"] + " " + workerDetails["zone"],
      achievement:
          'Ranked in Top ${this.rank} ${this.workerDetails["professionTitle"]} ',
      recording: workerDetails["ServiceDetails"]["Recording"],
      skills: workerDetails["ServiceDetails"]["Skills"],
    );
  }

  var rank;
  getRanking(id, prf) async {
    var a = (await ApiHandler()
            .makeGetRequest("/worker/ranting/district/${id}/${prf}"))
        .data;
    print(a);
    rank = a["count"];
  }

  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.jobTitle,
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
        body: this.workerDetails == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: Colors.grey[200],
                child: Stack(children: [
                  Container(
                    color: SColors.PrimaryColorPurple,
                    height: ScreenSizeConfig.safeBlockVertical * 25,
                    width: ScreenSizeConfig.safeBlockHorizontal * 100,
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        _cardDesign(workerDetailsComplete),
                      ]),
                    ),
                  )
                ]),
              ));
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

  Widget _cardDesign(WorkerDetailsComplete workerDetailsComplete) {
    return InkWell(
      onTap: () {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => WorkerDetails(jobTitle: widget.title)),
        // );
      },
      child: Padding(
        padding: EdgeInsets.all(ScreenSizeConfig.safeBlockHorizontal * 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(ScreenSizeConfig.safeBlockHorizontal * 3),
              child: Text(
                workerDetailsComplete.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSizeConfig.safeBlockHorizontal * 7),
              ),
            ),
            _cardNumberOne(),
            _componentTitle('About Me'),
            _cardNumberTwo(),
            _componentTitle('Skills'),
            _cardNumberThree(),
            //_componentTitle('Reviews'),
            //_cardNumberFour(Reviews),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                  width: ScreenSizeConfig.safeBlockHorizontal * 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey[400],
                        ),
                        child: TextButton(
                          child: Text(
                            'Contact Me',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    ScreenSizeConfig.safeBlockHorizontal * 5),
                          ),
                          onPressed: () async {
                            var url =
                                "tel://${this.workerDetailsComplete.phone}}";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: SColors.PrimaryColorPurple,
                        ),
                        child: TextButton(
                          child: Text(
                            '  Book Me  ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    ScreenSizeConfig.safeBlockHorizontal * 5),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return BookingsPopUp(
                                    name: workerDetailsComplete.name,
                                    worker: workerDetailsComplete,
                                  );
                                }));
                          },
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  _componentTitle(title) {
    return Padding(
      padding: EdgeInsets.all(ScreenSizeConfig.safeBlockHorizontal * 3),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black,
            fontSize: ScreenSizeConfig.safeBlockHorizontal * 4),
      ),
    );
  }

  _cardNumberOne() {
    return Container(
      width: ScreenSizeConfig.safeBlockHorizontal * 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    height: ScreenSizeConfig.safeBlockVertical * 5,
                    width: ScreenSizeConfig.safeBlockHorizontal * 10,
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 1),
                    child: Image.asset('assets/images/list_icon1.png')),
                Container(
                  child: Text(
                    workerDetailsComplete.experience,
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                    height: ScreenSizeConfig.safeBlockVertical * 5,
                    width: ScreenSizeConfig.safeBlockHorizontal * 10,
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 1),
                    child: Image.asset('assets/images/list_icon1_1.png')),
                Container(
                  child: Text(
                    workerDetailsComplete.startingPrice,
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                    height: ScreenSizeConfig.safeBlockVertical * 5,
                    width: ScreenSizeConfig.safeBlockHorizontal * 10,
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 1),
                    child: Image.asset('assets/images/list_icon2.png')),
                Container(
                  child: RatingBar.builder(
                    initialRating: workerDetailsComplete.rating * 5,
                    minRating: workerDetailsComplete.rating * 5,
                    maxRating: workerDetailsComplete.rating * 5,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: ScreenSizeConfig.safeBlockHorizontal * 5,
                    itemPadding: EdgeInsets.symmetric(
                        horizontal: ScreenSizeConfig.safeBlockHorizontal * 1),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (r) {},
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                    height: ScreenSizeConfig.safeBlockVertical * 5,
                    width: ScreenSizeConfig.safeBlockHorizontal * 10,
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 1),
                    child: Image.asset('assets/images/list_icon3.png')),
                Container(
                  child: Text(
                    workerDetailsComplete.location,
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                    height: ScreenSizeConfig.safeBlockVertical * 5,
                    width: ScreenSizeConfig.safeBlockHorizontal * 10,
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 1),
                    child: Image.asset('assets/images/list_icon4.png')),
                Container(
                  child: Flexible(
                    child: Text(
                      workerDetailsComplete.achievement,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _cardNumberTwo() {
    return Container(
      width: ScreenSizeConfig.safeBlockHorizontal * 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    height: ScreenSizeConfig.safeBlockVertical * 5,
                    width: ScreenSizeConfig.safeBlockHorizontal * 10,
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 1),
                    child: InkWell(
                        onTap: () async {
                          recording_but = !recording_but;

                          if (recording_but) {
                            var base64 =
                                base64Decode(workerDetailsComplete.recording);
                            var file = io.File(await this._localPath +
                                "/" +
                                workerDetailsComplete.name +
                                ".mpa4");

                            await file.writeAsBytes(base64);
                            int result = await audioPlayer.play(
                                await this._localPath +
                                    "/downloads/" +
                                    workerDetailsComplete.name +
                                    ".mpa4");
                          } else {
                            int result = await audioPlayer.stop();
                          }

                          setState(() {});
                        },
                        child: this.recording_but
                            ? Icon(Icons.stop)
                            : Icon(Icons.play_arrow))),
                Container(
                  child: Flexible(
                    child: Text(
                      " My Motive ",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _cardNumberThree() {
    return Container(
      width: ScreenSizeConfig.safeBlockHorizontal * 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    height: ScreenSizeConfig.safeBlockVertical * 5,
                    width: ScreenSizeConfig.safeBlockHorizontal * 10,
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 1),
                    child: Image.asset('assets/images/list_icon1.png')),
                Container(
                  child: Text(
                    workerDetailsComplete.experience,
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                    height: ScreenSizeConfig.safeBlockVertical * 5,
                    width: ScreenSizeConfig.safeBlockHorizontal * 10,
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 1),
                    child: Image.asset('assets/images/list_icon1_1.png')),
                Container(
                  child: Text(
                    workerDetailsComplete.startingPrice,
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardReviewItems() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: reviews.map<Widget>((p) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _componentTitle(p.name),
                Row(
                  children: [
                    Container(
                      child: RatingBar.builder(
                        initialRating: p.rating * 5,
                        minRating: p.rating * 5,
                        maxRating: p.rating * 5,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: ScreenSizeConfig.safeBlockHorizontal * 5,
                        itemPadding: EdgeInsets.symmetric(
                            horizontal:
                                ScreenSizeConfig.safeBlockHorizontal * 1),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (r) {},
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                          ScreenSizeConfig.safeBlockHorizontal * 2),
                      child: Flexible(
                        child: Text(
                          p.details,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ]);
        }).toList());
  }

  _cardNumberFour(Reviews) {
    return Container(
      width: ScreenSizeConfig.safeBlockHorizontal * 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(20.0), child: _cardReviewItems()),
    );
  }

  _popUpBookings() {
    return AlertDialog(title: Text('PopUp'));
  }
}
