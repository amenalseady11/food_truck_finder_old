import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_image/firebase_image.dart';
import '../colors.dart';
import '../models/profile_model.dart';

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
  @override
  Widget build(BuildContext context) {
    Profile profile;

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      profile = arguments['profile'];
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        //iconTheme: new IconThemeData(color: Colors.grey[800]),
        elevation: 0,
        centerTitle: true,
        //title: Text('Food Trucks'),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 50, // CHANGE THIS
                    color: primaryColor,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 0, // CHANGE THIS
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ListView(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // ==============================================
                              SizedBox(height: 20.0),
                              Image(
                                image: FirebaseImage(profile.logo),
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(height: 10.0),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  profile.name,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontFamily: 'OpenSans',
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Align(
                                alignment: Alignment.center,                                
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.restaurant, size: 20, color: primaryColor),
                                    SizedBox(width: 6.0),
                                    Text(
                                      profile.cuisine,
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontFamily: 'OpenSans',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  profile.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontFamily: 'OpenSans',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              // Align(
                              //   alignment: Alignment.center,                                
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Icon(Icons.gps_fixed, size: 20, color: primaryColor),
                              //       SizedBox(width: 6.0),
                              //       Text(
                              //         profile.latitude.toString() + ', ' + profile.longitude.toString(),
                              //         style: TextStyle(
                              //           color: Colors.grey[700],
                              //           fontFamily: 'OpenSans',
                              //           fontSize: 16.0,
                              //           fontWeight: FontWeight.normal,
                              //           fontStyle: FontStyle.italic,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              //_buildLoginBtn(),
                              // ==============================================
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }



}
