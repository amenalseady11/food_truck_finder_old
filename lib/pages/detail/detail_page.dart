import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../colors.dart';
import '../../models/foodtruck_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/my_title_widget.dart';
import '../../widgets/my_cuisine_widget.dart';
import '../../widgets/my_logo_widget.dart';
import '../../widgets/my_label_widget.dart';
import '../../widgets/my_images_widget.dart';
import '../../widgets/my_article_widget.dart';
import '../../widgets/my_formitem_widget.dart';

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
      blurRadius: 1.0,
      offset: Offset(0, 2),
    ),
  ],
);

// ----------------------------------------------------------------------------

_launchURL() async {
  const url = 'https://flutter.dev';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// ----------------------------------------------------------------------------

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GoogleMapController mapController;
  String _mapStyle;
  List<Marker> markers = <Marker>[];
  CameraPosition foodtruckLocation;

  @override
  void initState() {
    super.initState();
    //setCustomMapPin();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

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
        icon: BitmapDescriptor.defaultMarkerWithHue(15),
        onTap: () {},
      ));

      foodtruckLocation = CameraPosition(
        target: LatLng(foodtruck.latitude, foodtruck.longitude),
        zoom: 16,
      );
    }

    final String _imgL =
        'gs://foodtruckfinder-proj.appspot.com/' + foodtruck.imgL;
    final String _imgA =
        'gs://foodtruckfinder-proj.appspot.com/' + foodtruck.imgA;
    final String _imgB =
        'gs://foodtruckfinder-proj.appspot.com/' + foodtruck.imgB;
    final String _imgC =
        'gs://foodtruckfinder-proj.appspot.com/' + foodtruck.imgC;

    final List<String> imgList = [_imgA, _imgB, _imgC];

    TextEditingController txtEmail = TextEditingController();

    txtEmail.text = foodtruck.phone;

    CameraPosition myLocation = CameraPosition(
      target: LatLng(foodtruck.latitude, foodtruck.longitude),
      zoom: 15,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, //grey[100],
        iconTheme: new IconThemeData(color: skyorangeColor),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            children: [
              // --- HEADER ---
              MyLogo(path: _imgL),
              MyTitle(label: foodtruck.title),
              MyCuisine(label: foodtruck.cuisine),
              // --- IMAGES ---
              MyImages(list: imgList),
              // --- DESCRIPTION ---
              if (foodtruck.description.length > 0)
                MyLabel(label: 'Description'),
              if (foodtruck.description.length > 0)
                MyArticle(text: foodtruck.description),
              // --- LOCATION ---
              if (foodtruck.latitude != 0 || foodtruck.longitude != 0)
                MyLabel(label: 'Location'),
              if (foodtruck.latitude != 0 || foodtruck.longitude != 0)
                Container(
                  height: 200,
                  //width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(10), //border corner radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), //color of shadow
                        blurRadius: 2, // blur radius
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                      //you can set more BoxShadow() here
                    ],
                  ),
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    rotateGesturesEnabled: false,
                    buildingsEnabled: true,
                    mapToolbarEnabled: true,
                    zoomControlsEnabled: true,
                    initialCameraPosition: myLocation,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                      //mapController.setMapStyle(_mapStyle);
                    },
                    markers: Set<Marker>.of(markers),
                  ),
                ),

              // --- CONTACT ---
              if (foodtruck.phone.length > 0 ||
                  foodtruck.webpage.length > 0 ||
                  foodtruck.facebook.length > 0 ||
                  foodtruck.instagram.length > 0)
                MyLabel(label: 'Contact'),

              if (foodtruck.phone.length > 0 ||
                  foodtruck.webpage.length > 0 ||
                  foodtruck.facebook.length > 0 ||
                  foodtruck.instagram.length > 0)
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 20.0,
                    bottom: 10.0,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(10), //border corner radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), //color of shadow
                        blurRadius: 2, // blur radius
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                      //you can set more BoxShadow() here
                    ],
                  ),
                  child: Column(children: [
                    if (foodtruck.phone.length > 0)
                      MyFormItem(symbol: 'phone', text: foodtruck.phone),
                    if (foodtruck.webpage.length > 0)
                      MyFormItem(symbol: 'webpage', text: foodtruck.webpage),
                    if (foodtruck.facebook.length > 0)
                      MyFormItem(symbol: 'facebook', text: foodtruck.facebook),
                    if (foodtruck.instagram.length > 0)
                      MyFormItem(
                          symbol: 'instagram', text: foodtruck.instagram),
                  ]),
                ),

              // onTap: () async {
              //       String url =
              //           'https://www.facebook.com/' + foodtruck.facebook;
              //       if (await canLaunch(url)) {
              //         await launch(url);
              //       } else {
              //         throw 'Could not launch $url';
              //       }
              //     },
            ],
          ),
        ),
      ),
    );
  }

  await(ImageConfiguration imageConfiguration, String s) {}
}
