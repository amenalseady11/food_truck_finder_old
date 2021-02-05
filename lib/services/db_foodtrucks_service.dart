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
        'name': name,
        'cuisine': '',
        'description': '',
        'phone': '',
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
    String phone,
  ) async {
    return await foodtrucksCollection.doc().set(
      {
        'uid': uid,
        'name': name,
        'cuisine': cuisine,
        'description': description,
        'phone': phone,
      },
    );
  }

  Future<FoodTruck> readFoodTruck() async {
    final doc = await foodtrucksCollection.doc(uid).get();
    if (doc.exists) {
      return FoodTruck(
        id: doc.id,
        name: doc['name'] ?? '',
        cuisine: doc['cuisine'] ?? '',
        description: doc['description'] ?? '',
        phone: doc['phone'] ?? '',
        status: doc['status'] ?? false,
        latitude: (doc['latitude'] as num).toDouble() ?? (0 as double),
        longitude: (doc['longitude'] as num).toDouble() ?? (0 as double),
        localized: doc['localized'] ?? Timestamp(0, 0),
        created: doc['created'] ?? Timestamp(0, 0),
        updated: doc['updated'] ?? Timestamp(0, 0),
      );
    }
  }

  // trucks list from snapshot
  List<FoodTruck> _foodtrucksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodTruck(
        id: doc.id,
        name: doc['name'] ?? '',
        cuisine: doc['cuisine'] ?? '',
        description: doc['description'] ?? '',
        phone: doc.data()['phone'] ?? '',
        status: doc['status'] ?? false,
        latitude: (doc['latitude'] as num).toDouble() ?? (0 as double),
        longitude: (doc['longitude'] as num).toDouble() ?? (0 as double),
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
