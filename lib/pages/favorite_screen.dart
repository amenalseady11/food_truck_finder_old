import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import '../services/auth_service.dart';
import '../colors.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // user credentials
    final user = Provider.of<User>(context);

    // Wrapper
    if (user != null) {
      // Profiles screen
      return Container(
        padding: EdgeInsets.all(30),
        child: Text('Favorites'),
      );
    } else {
      // Login/Register screen
      return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/undraw_sign_in.svg',
                semanticsLabel: 'SignIn Image',
                height: 200,
                
              ),
              SizedBox(height: 60),
              Text(
                'Log into your personal account to start tracking your favorite food trucks!',
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.5,
                  //letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'OpenSans',  
                                  
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ));
    }
  }


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
        offset: Offset(0, 3),
      ),
    ],
  );

// ----------------------------------------------------------------------------
}
