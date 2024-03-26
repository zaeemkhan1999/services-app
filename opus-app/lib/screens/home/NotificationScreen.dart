import 'package:flutter/material.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/services/Lists.dart';
import 'package:opusapp/utils/Http-Service.dart';
import 'package:opusapp/utils/local-storage.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Notifications> notifications = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifications().then((e) {
      setState(() {});
    });
  }

  var notify = [];
  getNotifications() async {
    print("/booking/book/worker/notification/${Storage.getValue("worker_id")}");
    var resp = await ApiHandler().makeGetRequest(
        "/booking/book/worker/notification/${Storage.getValue("worker_id")}");
    notify = resp.data["notify"];
    notify.forEach((element) {
      this.notifications.add(
            new Notifications(
              title: element["client"]["fullName"],
              details: element["text"],
              time: element["createdAt"].toString().substring(0, 10),
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Notifications",
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
        body: this.notify.length == 0
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Container(
                    color: SColors.PrimaryColorPurple,
                    height: ScreenSizeConfig.safeBlockVertical * 20,
                    width: ScreenSizeConfig.safeBlockHorizontal * 100,
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [_notifications()],
                      ),
                    ),
                  ),
                ],
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

  Widget _notifications() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: notifications.map((p) {
          return _cardDesign(p);
        }).toList());
  }

  Widget _cardDesign(Notifications) {
    return Padding(
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
                Notifications.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenSizeConfig.safeBlockHorizontal * 5),
              ),
              Row(
                children: [
                  Container(
                    height: ScreenSizeConfig.safeBlockVertical * 5,
                    width: ScreenSizeConfig.safeBlockHorizontal * 5,
                    padding: EdgeInsets.all(
                        ScreenSizeConfig.safeBlockHorizontal * 1),
                  ),
                  Container(
                    width: ScreenSizeConfig.safeBlockHorizontal * 60,
                    child: Text(
                      Notifications.details,
                      maxLines: 3,
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
                  ),
                  Container(
                    child: Text(
                      Notifications.time,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
