//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodTruck {
  final String id; // foodtruck ID
  final String name;
  final String title;
  final String cuisine;
  final String description;
  final String phone;
  final String webpage;
  final String facebook;
  final String instagram;
        String imgL; // logo
        String imgA;
        String imgB;
        String imgC;
  final double latitude; // GPS
  final double longitude; // GPS
        double distance;
  final bool   enabled;
  final bool   open;
  final int    opening;
  final int    closing;
  final Timestamp localized;
  final Timestamp created; // UTC time
  final Timestamp updated; // UTC time

  FoodTruck(
      {
      this.id,
      this.name,
      this.title,
      this.cuisine,
      this.description,
      this.phone,
      this.webpage,
      this.facebook,
      this.instagram,
      this.imgL,
      this.imgA,
      this.imgB,
      this.imgC,
      this.enabled,
      this.open,
      this.opening,
      this.closing,
      this.latitude,
      this.longitude,
      this.distance,
      this.localized,
      this.created,
      this.updated,
      });
}
