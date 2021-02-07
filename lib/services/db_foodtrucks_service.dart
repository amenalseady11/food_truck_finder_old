import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/foodtruck_model.dart';

class DbFoodTrucksService {
  final String uid;
  DbFoodTrucksService({this.uid});

  // collection reference
  final CollectionReference foodtrucksCollection =
      FirebaseFirestore.instance.collection('foodtrucks');

  // update trucks data
  Future createFoodTruck() async {
    return await foodtrucksCollection.doc(uid).set(
      {
        'name': '',
        'email': '',
        'phone': '',
        'title': '',
        'cuisine': '',
        'description': '',
        'webpage': '',
        'facebook': '',
        'instagram': '',
        'enabled': false,
        'open': false,
        'opening': 0,
        'closing': 0,
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
    String title,
    String cuisine,
    String description,
    String webpage,
    String facebook,
    String instagram,
  ) async {
    return await foodtrucksCollection.doc().set(
      {
        'uid': uid,
        'name': name,
        'title': title,
        'cuisine': cuisine,
        'description': description,
        'webpage': webpage,
        'facebook': facebook,
        'instagram': instagram,
      },
    );
  }

  Future<FoodTruck> readFoodTruck() async {
    final doc = await foodtrucksCollection.doc(uid).get();
    if (doc.exists) {
      return FoodTruck(
        id: doc.id,
        name: doc['name'] ?? '',
        email: doc['email'] ?? '',
        phone: doc['phone'] ?? '',
        title: doc['title'] ?? '',
        cuisine: doc['cuisine'] ?? '',
        description: doc['description'] ?? '',
        webpage: doc['webpage'] ?? '',
        facebook: doc['facebook'] ?? '',
        instagram: doc['instagram'] ?? '',
        enabled: doc['enabled'] ?? false,
        open: doc['open'] ?? false,
        opening: doc['opening'] ?? false,
        closing: doc['closing'] ?? false,
        latitude: (doc['latitude'] as num).toDouble() ?? (0 as double),
        longitude: (doc['longitude'] as num).toDouble() ?? (0 as double),
        localized: doc['localized'] ?? Timestamp(0, 0),
        created: doc['created'] ?? Timestamp(0, 0),
        updated: doc['updated'] ?? Timestamp(0, 0),
      );
    } else {
      return null;
    }
  }

  // trucks list from snapshot
  List<FoodTruck> _foodtrucksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodTruck(
        id: doc.id,
        name: doc.data()['name'] ?? '',
        email: doc.data()['email'] ?? '',
        phone: doc.data()['phone'] ?? '',
        title: doc.data()['title'] ?? '',
        cuisine: doc.data()['cuisine'] ?? '',
        description: doc.data()['description'] ?? '',
        webpage: doc.data()['webpage'] ?? '',
        facebook: doc.data()['facebook'] ?? '',
        instagram: doc.data()['instagram'] ?? '',
        enabled: doc.data()['enabled'] ?? false,
        open: doc.data()['open'] ?? false,
        opening: doc.data()['opening'] ?? 0,
        closing: doc.data()['closing'] ?? 0,
        latitude: (doc.data()['latitude'] as num).toDouble() ?? (0 as double),
        longitude: (doc.data()['longitude'] as num).toDouble() ?? (0 as double),
        localized: doc.data()['localized'] ?? Timestamp(0, 0),
        created: doc.data()['created'] ?? Timestamp(0, 0),
        updated: doc.data()['updated'] ?? Timestamp(0, 0),
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
