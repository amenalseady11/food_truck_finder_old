//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodTruck {
  final String id; // foodtruck ID
  final String uid; // user ID
  final String name;
  final String cuisine;
  final String description;
  final String phone;
  final String imgL; // logo
  final String imgA;
  final String imgB;
  final String imgC;
  final bool status;
  final double latitude; // GPS
  final double longitude; // GPS
        double distance;
  final Timestamp localized;
  final Timestamp created; // UTC time
  final Timestamp updated; // UTC time

  FoodTruck(
      {this.id,
      this.uid,
      this.name,
      this.cuisine,
      this.description,
      this.phone,
      this.imgL,
      this.imgA,
      this.imgB,
      this.imgC,
      this.status,
      this.latitude,
      this.longitude,
      this.distance,
      this.localized,
      this.created,
      this.updated});
}
