import 'package:flutter/material.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/services/PopUps/BookingsPopUp.dart';
import 'package:opusapp/screens/services/Lists.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:opusapp/screens/services/WorkerDetails.dart';
import 'package:opusapp/utils/Http-Service.dart';

class Service extends StatefulWidget {
  var title;
  var id;
  Service({@required this.title, @required this.id});
  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  List<ServiceProviders> serviceProviders = [];

  var workers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllWorkers().then((e) {
      setState(() {});
    });
  }

  getAllWorkers() async {
    var resp =
        await ApiHandler().makeGetRequest("/worker/profId/all/${widget.id}");
    print(resp);
    this.workers = resp.data["Worker"];
    this.workers.forEach((worker) async {
      await getRanking(worker["_id"], worker["ServiceDetails"]["Service"]);
      this.serviceProviders.add(ServiceProviders(
            id: worker["_id"],
            name: worker["fullName"],
            experience:
                '${worker["ServiceDetails"]["WorkExperiance"]} Years experience',
            rating: double.parse(worker["rating"].toString()),
            location: worker["city"] + worker["zone"],
            achievement:
                'Ranked in Top ${this.rank} ${worker["professionTitle"]} ',
          ));
      setState(() {});
    });
  }

  var rank;
  getRanking(id, prf) async {
    var a = (await ApiHandler()
            .makeGetRequest("/worker/ranting/district/${id}/${prf}"))
        .data;
    print(a);
    rank = a["count"];
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: this.workers.length == 0
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.grey[300],
              child: Stack(
                children: [
                  Container(
                    color: SColors.PrimaryColorPurple,
                    height: ScreenSizeConfig.safeBlockVertical * 35,
                    width: ScreenSizeConfig.safeBlockHorizontal * 100,
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: ScreenSizeConfig.safeBlockVertical * 7,
                            width: ScreenSizeConfig.safeBlockHorizontal * 100,
                          ),
                          _inkwells(),
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            width: ScreenSizeConfig.safeBlockHorizontal * 100,
                            padding: EdgeInsets.fromLTRB(
                                ScreenSizeConfig.safeBlockHorizontal * 8,
                                ScreenSizeConfig.safeBlockHorizontal * 7,
                                0,
                                ScreenSizeConfig.safeBlockHorizontal * 3),
                            child: Row(
                              children: [
                                Text(
                                  'SHOWING: ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          ScreenSizeConfig.safeBlockHorizontal *
                                              5),
                                ),
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          ScreenSizeConfig.safeBlockHorizontal *
                                              5),
                                ),
                              ],
                            ),
                          ),
                          _employees(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget _employees() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: serviceProviders.map((p) {
          return _cardDesign(p);
        }).toList());
  }

  Widget _cardDesign(ServiceProviders serviceProviders) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WorkerDetails(
                  jobTitle: widget.title, id: serviceProviders.id)),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(ScreenSizeConfig.safeBlockHorizontal * 6),
        child: Container(
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
                Text(
                  serviceProviders.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenSizeConfig.safeBlockHorizontal * 5),
                ),
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
                        serviceProviders.experience,
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
                        initialRating: serviceProviders.rating * 5,
                        minRating: serviceProviders.rating * 5,
                        maxRating: serviceProviders.rating * 5,
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
                        height: ScreenSizeConfig.safeBlockVertical * 5,
                        width: ScreenSizeConfig.safeBlockHorizontal * 10,
                        padding: EdgeInsets.all(
                            ScreenSizeConfig.safeBlockHorizontal * 1),
                        child: Image.asset('assets/images/list_icon3.png')),
                    Container(
                      child: Text(
                        serviceProviders.location,
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
                          serviceProviders.achievement,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
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
            width: ScreenSizeConfig.safeBlockHorizontal * 50,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Opacity(
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
