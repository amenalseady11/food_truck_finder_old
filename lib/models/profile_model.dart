//import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String id;
  final String uid;
  final String name;
  final String cuisine;
  final String description;
  final String facebook;
  final String instagram;
  final double latitude;
  final double longitude;
  final String image;
  //final Timestamp updated;
  final bool open;

  Profile({
    this.id,
    this.uid,
    this.name,
    this.cuisine,
    this.description,
    this.facebook,
    this.instagram,
    this.latitude,
    this.longitude,
    this.image,
    //this.updated,
    this.open,
  });
}