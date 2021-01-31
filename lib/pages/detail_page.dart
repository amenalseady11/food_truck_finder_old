import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../colors.dart';
import '../models/foodtruck_model.dart';
import '../widgets/mysmalliconlabel_widget.dart';
import '../widgets/mysymbol_direction_widget.dart';
import '../widgets/mysymbol_facebook_widget.dart';
import '../widgets/mysymbol_instagram_widget.dart';
import '../widgets/mysymbol_web_widget.dart';
import '../widgets/mysymbol_heart_widget.dart';

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

  CameraPosition foodtruckLocation;

  @override
  Widget build(BuildContext context) {
    FoodTruck foodtruck;

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      foodtruck = arguments['foodtruck'];

      markers.add(Marker(
        markerId: MarkerId(foodtruck.id),
        position: LatLng(foodtruck.latitude, foodtruck.longitude),
        //infoWindow:
        //    InfoWindow(title: foodtruck.name, snippet: foodtruck.cuisine),
        icon: BitmapDescriptor.defaultMarkerWithHue((foodtruck.status)
            ? BitmapDescriptor.hueGreen
            : BitmapDescriptor.hueRed),
        onTap: () {},
      ));

      foodtruckLocation = CameraPosition(
        target: LatLng(foodtruck.latitude, foodtruck.longitude),
        zoom: 16,
      );
    }

    final String _imgL = 'gs://foodtruckfinder-proj.appspot.com/' +
        foodtruck.id.toString() +
        '_L.jpg';
    final String _imgA = 'gs://foodtruckfinder-proj.appspot.com/' +
        foodtruck.id.toString() +
        '_A.jpg';
    final String _imgB = 'gs://foodtruckfinder-proj.appspot.com/' +
        foodtruck.id.toString() +
        '_B.jpg';
    final String _imgC = 'gs://foodtruckfinder-proj.appspot.com/' +
        foodtruck.id.toString() +
        '_C.jpg';

    final List<String> imgList = [_imgA, _imgB, _imgC];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: new IconThemeData(color: truckblackColor),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map -----
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: false,
                compassEnabled: false,
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: true,
                buildingsEnabled: true,
                initialCameraPosition: foodtruckLocation,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                markers: Set<Marker>.of(markers),
              ),
            ),
            // Title -----
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image(
                      image: FirebaseImage(_imgL),
                      fit: BoxFit.fitHeight,
                      width: 60,
                      height: 60,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${foodtruck.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          MySmallIconLabel(
                            symbol: 'cuisine',
                            label: foodtruck.cuisine,
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          MySmallIconLabel(
                            symbol: 'place',
                            label: '0.0 km',
                            open: foodtruck.status,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[200],
              height: 3,
              indent: 20,
              endIndent: 20,
            ),
            // SYMBOLS ------
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MySymbolDirection(),
                  MySymbolWeb(),
                  MySymbolFacebook(),
                  MySymbolInstagram(),
                  MySymbolHeart(),
                ],
              ),
            ),
            // DESCRIPTION -----
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                '${foodtruck.description}',
                style: TextStyle(
                  color: truckblackColor,
                  fontWeight: FontWeight.normal,
                  height: 1.4,
                  fontSize: 16,
                ),
              ),
            ),
            Divider(
              color: Colors.grey[200],
              height: 3,
              indent: 20,
              endIndent: 20,
            ),
            // IMAGES -----
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: CarouselSlider(
                options: CarouselOptions(enlargeCenterPage: true),
                items: imgList
                    .map(
                      (item) => Container(
                        child: Image(
                          image: FirebaseImage(item),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Divider(
              color: Colors.grey[200],
              height: 3,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 100.0,
            ),
            // Symbols------
            // Container(
            //   padding: EdgeInsets.all(10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //       // Column 1 =
            //       Container(
            //         child: Column(
            //           children: [
            //             Icon(
            //               Icons.near_me_outlined,
            //               color: truckblackColor,
            //               size: 30.0,
            //             ),
            //             Text(
            //               'Directions',
            //               style: TextStyle(
            //                   fontWeight: FontWeight.normal, fontSize: 12),
            //             ),
            //           ],
            //         ),
            //       ),
            //       // Column 2 =
            //       Container(
            //         child: Column(
            //           children: [
            //             Icon(
            //               Icons.public,
            //               color: truckblackColor,
            //               size: 30.0,
            //             ),
            //             Text(
            //               'Facebook',
            //               style: TextStyle(
            //                   fontWeight: FontWeight.normal, fontSize: 12),
            //             ),
            //           ],
            //         ),
            //       ),
            //       // Column 3 =
            //       Container(
            //         child: Column(
            //           children: [
            //             Icon(
            //               Icons.favorite_outline,
            //               color: truckblackColor,
            //               size: 30.0,
            //             ),
            //             Text(
            //               'Favorite',
            //               style: TextStyle(
            //                   fontWeight: FontWeight.normal, fontSize: 12),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  await(ImageConfiguration imageConfiguration, String s) {}
}
