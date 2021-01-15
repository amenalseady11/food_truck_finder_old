import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/profile_model.dart';

class DbProfilesService {
  final String uid;
  DbProfilesService({this.uid});

// collection reference
  final CollectionReference profilesCollection =
      FirebaseFirestore.instance.collection('profiles');

  // update trucks data
  Future updateTruck(
    String name,
    String cuisine,
    String description,
    String logo,
  ) async {
    return await profilesCollection.doc().set(
      {
        'uid': uid,
        'name': name,
        'cuisine': cuisine,
        'description': description,
        'logo': logo,
      },
    );
  }

 // trucks list from snapshot
  List<Profile> _profilesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Profile(
        id: doc.id,
        uid: doc['uid'] ?? '',
        name: doc['name'] ?? '',
        cuisine: doc['cuisine'] ?? '',
        description: doc['description'] ?? '',
        logo: doc['logo'] ?? '',
      );
    }).toList();
  }

    // get trucks data streams
  Stream<List<Profile>> get profiles {
    return profilesCollection
        .orderBy('name')
        .snapshots()
        .map(_profilesListFromSnapshot);
  }
}
