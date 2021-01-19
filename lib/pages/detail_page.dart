import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../colors.dart';
import '../models/foodtruck_model.dart';

// ----------------------------------------------------------------------------

final kHintTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

// ----------------------------------------------------------------------------

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GoogleMapController mapController;

  List<Marker> markers = <Marker>[];

  CameraPosition myLocation = CameraPosition(
    target: LatLng(37, -122),
    zoom: 11,
  );

  @override
  Widget build(BuildContext context) {
    FoodTruck foodtruck;

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      foodtruck = arguments['foodtruck'];
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: new IconThemeData(color: truckblackColor),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Map -----
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              compassEnabled: false,
              buildingsEnabled: true,
              initialCameraPosition: myLocation,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: Set<Marker>.of(markers),
            ),
          ),
          // Title -----
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image(
                    image: FirebaseImage(foodtruck.imgL),
                    fit: BoxFit.fitHeight,
                    width: 70,
                    height: 70,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 3,
                  margin: EdgeInsets.all(0),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  '${foodtruck.name}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                )
              ],
            ),
          ),
          // Divider -----
          Divider(
            height: 3,
          ),
          // Symbols------
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Column 1 =
                Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.near_me_outlined,
                        color: truckblackColor,
                        size: 36.0,
                      ),
                      Text(
                        'Directions',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                // Column 2 =
                Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.public,
                        color: truckblackColor,
                        size: 36.0,
                      ),
                      Text(
                        'Facebook',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                // Column 3 =
                Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite_outline,
                        color: truckblackColor,
                        size: 36.0,
                      ),
                      Text(
                        'Favorite',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Divider -----
          Divider(
            height: 3,
          ),
        ],
      ),
    );
  }
}
