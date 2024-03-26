import 'package:flutter/material.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:opusapp/screens/services/Service.dart';
import 'package:opusapp/utils/Http-Service.dart';

class MapScreen extends StatefulWidget {
  var title;
  var id;
  MapScreen({@required this.title, @required this.id});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController controller;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllWorkers().then((e) {
      setState(() {});
    });
  }

  var workers = [];
  getAllWorkers() async {
    var resp =
        await ApiHandler().makeGetRequest("/worker/profId/all/${widget.id}");
    print(resp);
    this.workers = resp.data["Worker"];
    print(workers[0]);
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "SHOWING: " + widget.title,
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
      body: this.workers.length == 0
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              compassEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(24.925676973482755, 67.06017640946023),
                zoom: 11.0,
              ),
              markers: _createMarker(workers),
              liteModeEnabled: false,
            ),
    );
  }

  Set<Marker> _createMarker(List workers) {
    var markers = new Set<Marker>();
    workers.forEach((element) {
      markers.add(Marker(
          markerId: MarkerId(element["_id"]),
          position:
              LatLng(element["location"]["lat"], element["location"]["log"]),
          infoWindow: InfoWindow(
              title: element["fullName"],
              snippet: '${element["fullName"]} out of 5')));
    });
    return markers;
  }

  Widget _inkwells() {
    return Container(
      color: SColors.PrimaryColorPurple,
      child: Row(
        children: [
          Container(
            width: ScreenSizeConfig.safeBlockHorizontal * 50,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenSizeConfig.safeBlockHorizontal * 5,
                  ScreenSizeConfig.safeBlockHorizontal * 5,
                  0,
                  0),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenSizeConfig.safeBlockHorizontal * 5.25, 0, 0),
                    child: Opacity(
                      opacity: 0.4,
                      child: Container(
                        height: ScreenSizeConfig.safeBlockVertical * 4.5,
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
          Container(
            width: ScreenSizeConfig.safeBlockHorizontal * 50,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0,
                  ScreenSizeConfig.safeBlockHorizontal * 5,
                  ScreenSizeConfig.safeBlockHorizontal * 5,
                  0),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Opacity(
                      opacity: 0.4,
                      child: Container(
                        height: ScreenSizeConfig.safeBlockVertical * 4.5,
                        width: ScreenSizeConfig.safeBlockHorizontal * 7.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Service(title: widget.title, id: widget.id)),
                        );
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.list,
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
