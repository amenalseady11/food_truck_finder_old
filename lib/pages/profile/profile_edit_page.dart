import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:food_truck_finder/services/auth_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

import '../../colors.dart';
import '../../models/foodtruck_model.dart';

import '../../widgets/my_title_widget.dart';
import '../../widgets/my_cuisine_widget.dart';
import '../../widgets/my_logo_widget.dart';
import '../../widgets/my_label_widget.dart';
import '../../widgets/my_image_widget.dart';
import '../../widgets/my_article_widget.dart';
import '../../widgets/my_formitem_widget.dart';
import '../../widgets/my_about_widget.dart';

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

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtCuisine = TextEditingController();
  TextEditingController txtFacebook = TextEditingController();
  TextEditingController txtInstagram = TextEditingController();
  TextEditingController txtWebpage = TextEditingController();

  File _imgFileL;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final foodtrucks = Provider.of<List<FoodTruck>>(context);
    FoodTruck profile;
    String _imgL;
    String _imgA;
    String _imgB;
    String _imgC;
    GoogleMapController mapController;
    String _mapStyle;
    List<Marker> markers = <Marker>[];
    CameraPosition foodtruckLocation;

    // Read foodtruck profile data from database
    if (foodtrucks != null) {
      profile =
          foodtrucks.firstWhere((item) => item.id == user.uid, orElse: () {
        return null;
      });

      if (profile != null) {
        txtTitle.text = profile.title;
        txtCuisine.text = profile.cuisine;
        txtFacebook.text = profile.facebook;
        txtInstagram.text = profile.instagram;
        txtWebpage.text = profile.webpage;
      }
    }

    _imgL = 'gs://foodtruckfinder-proj.appspot.com/' +
        profile.id.toString() +
        '_L.jpg';

    _imgA = 'gs://foodtruckfinder-proj.appspot.com/' +
        profile.id.toString() +
        '_A.jpg';

    _imgB = 'gs://foodtruckfinder-proj.appspot.com/' +
        profile.id.toString() +
        '_B.jpg';

    _imgC = 'gs://foodtruckfinder-proj.appspot.com/' +
        profile.id.toString() +
        '_C.jpg';

    CameraPosition myLocation = CameraPosition(
      target: LatLng(profile.latitude, profile.longitude),
      zoom: 15,
    );

    markers.add(Marker(
      markerId: MarkerId(profile.id),
      position: LatLng(profile.latitude, profile.longitude),
      //infoWindow:
      //    InfoWindow(title: foodtruck.name, snippet: foodtruck.cuisine),
      icon: BitmapDescriptor.defaultMarkerWithHue(15),
      onTap: () {},
    ));

    foodtruckLocation = CameraPosition(
      target: LatLng(profile.latitude, profile.longitude),
      zoom: 16,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, //grey[100],
        iconTheme: new IconThemeData(color: skyorangeColor),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: "Save",
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),
        ],
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
              // LOGO -----
              MyLabel(label: 'Logo'),
              MyLogo(path: _imgL),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      MdiIcons.folderImage,
                      color: skyorangeColor,
                    ),
                    tooltip: "Logo from gallery",
                    onPressed: () async {
                      PickedFile pickedFile = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                        maxWidth: 800,
                        maxHeight: 800,
                      );
                      if (pickedFile != null) {
                        File imageFile = File(pickedFile.path);
                      }

                      //Navigator.pushNamed(context, "/logo_gallery");
                    },
                  ),
                  SizedBox(width: 30),
                  IconButton(
                    icon: Icon(
                      MdiIcons.camera,
                      color: skyorangeColor,
                    ),
                    tooltip: "Logo from camera",
                    onPressed: () async {
                      PickedFile pickedFile = await ImagePicker().getImage(
                        source: ImageSource.camera,
                        maxWidth: 800,
                        maxHeight: 800,
                      );
                      if (pickedFile != null) {
                        File imageFile = File(pickedFile.path);
                      }

                      //Navigator.pushNamed(context, "/logo_gallery");
                    },
                  ),
                ],
              ),
              // DESCRIPTION -----
              MyLabel(label: 'Desciption'),
              _buildTitleTF(),
              _buildCuisineTF(),
              // CONTACTS -----
              MyLabel(label: 'Contacts'),
              _buildWebpageTF(),
              _buildFacebookTF(),
              _buildInstagramTF(),
              // IMAGES -----
              MyLabel(label: 'Images'),
              MyImage(path: _imgA),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      MdiIcons.folderImage,
                      color: skyorangeColor,
                    ),
                    tooltip: "Logo from gallery",
                    onPressed: () {
                      Navigator.pushNamed(context, "/logo_gallery");
                    },
                  ),
                  SizedBox(width: 30),
                  IconButton(
                    icon: Icon(
                      MdiIcons.camera,
                      color: skyorangeColor,
                    ),
                    tooltip: "Logo from camera",
                    onPressed: () {
                      Navigator.pushNamed(context, "/logo_gallery");
                    },
                  ),
                ],
              ),
              MyImage(path: _imgB),
              MyImage(path: _imgC),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------

  Widget _buildTitleTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextFormField(
        controller: txtTitle,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: truckblackColor,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            MdiIcons.tag,
            color: truckblackColor,
          ),
          hintText: 'Enter your Title',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildCuisineTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextFormField(
        controller: txtCuisine,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: truckblackColor,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            MdiIcons.silverware,
            color: truckblackColor,
          ),
          hintText: 'Enter your Cuisine',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildFacebookTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextFormField(
        controller: txtFacebook,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: truckblackColor,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            MdiIcons.facebook,
            color: truckblackColor,
          ),
          hintText: 'Enter your Facebook',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildInstagramTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextFormField(
        controller: txtInstagram,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: truckblackColor,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            MdiIcons.instagram,
            color: truckblackColor,
          ),
          hintText: 'Enter your Instagram',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildWebpageTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextFormField(
        controller: txtWebpage,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: truckblackColor,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            MdiIcons.web,
            color: truckblackColor,
          ),
          hintText: 'Enter your Webpage',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }
}
