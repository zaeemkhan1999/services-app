import 'package:flutter/material.dart';

class ServiceProviders {
  String id;
  String name;
  String experience;
  double rating;
  String location;
  String achievement;
  ServiceProviders(
      {this.name,
      this.experience,
      this.rating,
      this.location,
      this.id,
      this.achievement});
}

class Location {
  double lat;
  double lng;
  Location({this.lat, this.lng});
}

class WorkerDetailsComplete {
  String id;
  String name;
  String experience;
  String startingPrice;
  double rating;
  String location;
  String achievement;
  String recording;
  String phone;
  String skills;
  WorkerDetailsComplete(
      {this.id,
      this.name,
      this.experience,
      this.startingPrice,
      this.rating,
      this.location,
      this.phone,
      this.achievement,
      this.recording,
      this.skills});
}

class Reviews {
  String name;
  double rating;
  String details;
  Reviews({this.name, this.rating, this.details});
}

class Notifications {
  String title;
  String details;
  String time;
  Notifications({this.title, this.details, this.time});
}
