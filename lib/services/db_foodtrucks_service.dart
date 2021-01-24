import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/foodtruck_model.dart';

class DbFoodTrucksService {
  final String uid;
  DbFoodTrucksService({this.uid});

  // collection reference
  final CollectionReference foodtrucksCollection =
      FirebaseFirestore.instance.collection('foodtrucks');

  // update trucks data
  Future createFoodTruck(
    String name,
  ) async {
    return await foodtrucksCollection.doc(uid).set(
      {
        'uid': uid,
        'name': name,
        'cuisine': '',
        'description': '',
        'imgL': '',
        'imgA': '',
        'imgB': '',
        'imgC': '',
        'status': false,
        'latitude': 0.0,
        'longitude': 0.0,
        'localized': Timestamp.fromDate(DateTime(1970, 1, 1, 0, 0)),
        'created': Timestamp.now(),
        'updated': Timestamp.now(),
      },
    );
  }

  // update trucks data
  Future updateFoodTruck(
    String name,
    String cuisine,
    String description,
  ) async {
    return await foodtrucksCollection.doc().set(
      {
        'uid': uid,
        'name': name,
        'cuisine': cuisine,
        'description': description,
      },
    );
  }

  // trucks list from snapshot
  List<FoodTruck> _foodtrucksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodTruck(
        id: doc.id,
        uid: doc['uid'] ?? '',
        name: doc['name'] ?? '',
        cuisine: doc['cuisine'] ?? '',
        description: doc['description'] ?? '',
        imgL: doc['imgL'] ?? '',
        imgA: doc['imgA'] ?? '',
        imgB: doc['imgB'] ?? '',
        imgC: doc['imgC'] ?? '',
        status: doc['status'] ?? false,
        latitude: doc['latitude'] ?? (0 as double),
        longitude: doc['longitude'] ?? (0 as double),
        localized: doc['localized'] ?? Timestamp(0, 0),
        created: doc['created'] ?? Timestamp(0, 0),
        updated: doc['updated'] ?? Timestamp(0, 0),
      );
    }).toList();
  }

  // get trucks data streams
  Stream<List<FoodTruck>> get foodtrucks {
    return foodtrucksCollection
        .orderBy('name')
        .snapshots()
        .map(_foodtrucksListFromSnapshot);
  }
}
