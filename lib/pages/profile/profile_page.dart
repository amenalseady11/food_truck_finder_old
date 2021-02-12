import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:food_truck_finder/services/auth_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final foodtrucks = Provider.of<List<FoodTruck>>(context);
    FoodTruck profile;
    GoogleMapController mapController;
    String _mapStyle;
    List<Marker> markers = <Marker>[];
    CameraPosition foodtruckLocation;

    // PROFILE page -----------------------------------------------------------
    if (user != null) {
      // Read foodtruck profile data from database
      if (foodtrucks != null) {
        profile =
            foodtrucks.firstWhere((item) => item.id == user.uid, orElse: () {
          return null;
        });
      }

      final String _imgL =
          'gs://foodtruckfinder-proj.appspot.com/' + profile.imgL;
      final String _imgA =
          'gs://foodtruckfinder-proj.appspot.com/' + profile.imgA;
      final String _imgB =
          'gs://foodtruckfinder-proj.appspot.com/' + profile.imgB;
      final String _imgC =
          'gs://foodtruckfinder-proj.appspot.com/' + profile.imgC;

      final List<String> imgList = [_imgA, _imgB, _imgC];

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
              icon: Icon(Icons.edit),
              tooltip: "Edit",
              onPressed: () {
                Navigator.pushNamed(context, "/profile_edit");
                setState(() {});
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
                // --- USER HEADER ---
                MyTitle(label: profile.name),
                MyCuisine(label: profile.email),
                MyCuisine(label: profile.phone),
                // -----
                Divider(thickness: 1, height: 20),
                // --- PROFILE HEADER ---
                MyLogo(path: _imgL),
                MyTitle(label: profile.title),
                MyCuisine(label: profile.cuisine),
                // --- LOCATION ---
                MyLabel(label: 'Location'),
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
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: myLocation,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                      mapController.setMapStyle(_mapStyle);
                    },
                    markers: Set<Marker>.of(markers),
                  ),
                ),
                // --- DESCRIPTION ---
                MyLabel(label: 'Description'),
                MyArticle(text: profile.description),
                // --- IMAGES ---
                MyLabel(label: 'Gallery'),
                MyImages(list: imgList),
                // --- CONTACT ---
                MyLabel(label: 'Contact'),
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
                    MyFormItem(symbol: 'webpage', text: profile.webpage),
                    MyFormItem(symbol: 'facebook', text: profile.facebook),
                    MyFormItem(symbol: 'instagram', text: profile.instagram),
                  ]),
                ),

                // --- ACTIONS ---
                MyLabel(label: 'Actions'),
                // Logout -----
                Container(
                  padding: EdgeInsets.only(bottom: 20.0),
                  width: double.infinity,
                  child: OutlineButton(
                    //elevation: 5.0,
                    borderSide: BorderSide(
                        color: skyorangeColor,
                        width: 1,
                        style: BorderStyle.solid),
                    splashColor: skyorangeColor,
                    onPressed: () async {
                      try {
                        final AuthService _auth = AuthService();
                        dynamic rc = await _auth.signOut();
                        Navigator.pushReplacementNamed(context, "/profile");
                        //ackAlert(context);
                      } on FirebaseAuthException catch (e) {
                        //errAlert(context, 'Warning', e.message);
                      } catch (e) {
                        //errAlert(context, 'Error', e.toString());
                      }
                    },
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: skyorangeColor,
                    child: Text(
                      'LOG OUT',
                      style: TextStyle(
                        color: skyorangeColor,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    // LOGIN page -------------------------------------------------------------
    else {
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
              bottom: 400,
            ),
            child: Column(
              children: [
                // --- ABOUT ---
                MyAbout(),
                Divider(
                  height: 100,
                  color: Colors.grey[400],
                  thickness: 1,
                ),
                // --- LOGIN ---
                MyTitle(label: 'Login'),
                _buildEmailTF(),
                _buildPasswordTF(),
                _buildLoginBtn(),
                _buildTermsLB(),
              ],
            ),
          ),
        ),
      );
    }
  }

  // --------------------------------------------------------------------------

  Widget _buildEmailTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextFormField(
        controller: txtEmail,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.grey[700],
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.grey[700],
          ),
          hintText: 'Enter your Email',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildPasswordTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextFormField(
        controller: txtPassword,
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        style: TextStyle(
          color: Colors.grey[700],
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.grey[700],
          ),
          hintText: 'Enter your Password',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          try {
            final AuthService _auth = AuthService();
            dynamic rc = await _auth.signinWithEmailAndPassword(
                txtEmail.text, txtPassword.text);
            Navigator.pushReplacementNamed(context, "/profile");
            //ackAlert(context);
          } on FirebaseAuthException catch (e) {
            //errAlert(context, 'Warning', e.message);
          } catch (e) {
            //errAlert(context, 'Error', e.toString());
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        //color: Theme.of(context).primaryColor,
        color: primaryColor,
        child: Text(
          'Log In',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildTermsLB() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 0.0),
      alignment: Alignment.topCenter,
      child: Text(
        'By signing up for FoodTruckFinder you agree to our Terms of Service and Privacy Policy',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: truckblackColor,
          //letterSpacing: 1.5,
          height: 1.5,
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }
}
