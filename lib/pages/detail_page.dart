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
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.white, //grey[100],
        iconTheme: new IconThemeData(color: truckblackColor),
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 60,
        title: Column(
          children: [
            Text(
              '${foodtruck.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '${foodtruck.cuisine}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: lightgreyColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // IMAGES -----
            Container(
              padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                    enlargeCenterPage: false,
                    pageSnapping: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale),
                items: imgList
                    .map(
                      (item) => Container(
                        padding: EdgeInsets.only(
                            left: 0, right: 0, top: 0, bottom: 0),
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
            Container(
              height: 10,
            ),
            // DESCRIPTION -----
            Container(
              color: Colors.white,
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                '${foodtruck.description}',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: truckblackColor,
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            ListTile(
                tileColor: Colors.white,
                dense: true,
                visualDensity: VisualDensity.compact,
                title: Text('Phone',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
                subtitle: Text('${foodtruck.phone}',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.black))),

            Divider(
                color: lightgreyColor,
                thickness: 1,
                height: 0,
                indent: 10,
                endIndent: 0),
            ListTile(
                tileColor: Colors.white,
                dense: true,
                visualDensity: VisualDensity.compact,
                title: Text('Web',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
                subtitle: Text('www.foodtrickfinder.eu',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.black))),
            Divider(
                color: lightgreyColor,
                thickness: 1,
                height: 0,
                indent: 10,
                endIndent: 0),
            ListTile(
                tileColor: Colors.white,
                dense: true,
                visualDensity: VisualDensity.compact,
                title: Text('Facebook',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
                subtitle: Text('@foodtrickfindereu',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.black))),
            Divider(
                color: lightgreyColor,
                thickness: 1,
                height: 0,
                indent: 10,
                endIndent: 0),
            ListTile(
                tileColor: Colors.white,
                dense: true,
                visualDensity: VisualDensity.compact,
                title: Text('Instagram',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
                subtitle: Text('@foodtrickfindereu',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.black))),

            Container(
              height: 10,
              color: lightgreyColor,
            ),
          ],
        ),
      ),
    );
  }

  await(ImageConfiguration imageConfiguration, String s) {}
}
