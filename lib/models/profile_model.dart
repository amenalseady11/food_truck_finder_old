//import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String id;
  final String uid;
  final String name;
  final String cuisine;
  final String description;

  Profile({
    this.id,
    this.uid,
    this.name,
    this.cuisine,
    this.description,
  });
}