//import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String id;
  final String uid;
  final String name;
  final String cuisine;
  final String description;
  final String logo;

  Profile(
      {this.id,
      this.uid,
      this.name,
      this.cuisine,
      this.description,
      this.logo});
}
