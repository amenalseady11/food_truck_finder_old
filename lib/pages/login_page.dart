import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_finder/services/auth_service.dart';
import 'package:food_truck_finder/widgets/mytabtitle_widget.dart';
import 'package:provider/provider.dart';
import '../services/location_service.dart';
import '../services/db_foodtrucks_service.dart';
import '../models/userlocation_model.dart';
import '../models/foodtruck_model.dart';
import '../colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {   

    return MultiProvider(
      providers: [
        StreamProvider<List<FoodTruck>>.value(
            value: DbFoodTrucksService().foodtrucks),
        StreamProvider<UserLocation>.value(
          value: LocationService().locationStream,
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: truckblackColor),
          elevation: 3,
          centerTitle: true,
          title: Image.asset(
            'assets/FTF_Icon_Transp.png',
            height: 40.0,
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.edit),
          //     tooltip: "Edit",
          //     onPressed: () {
          //       Navigator.pushNamed(context, "/edit");
          //     },
          //   ),
          // ],
        ),
        body: Container(
          //height: MediaQuery.of(context).size.height,
          //width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: DefaultTabController(
            length: 2, // length of tabs
            initialIndex: 0,
            child: Column(
              children: <Widget>[
                TabBar(
                  labelColor: primaryColor,
                  indicatorColor: primaryColor,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: MyTabTitle(title: 'Login'),
                    ),
                    Tab(
                      child: MyTabTitle(title: 'Register'),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      // --- LOGIN part ---
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 30),
                              _buildEmailTF(),
                              _buildPasswordTF(),
                              _buildLoginBtn(),
                            ],
                          ),
                        ),
                      ),
                      // --- REGISTER part ---
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 30),
                              _buildEmailTF(),
                              _buildPasswordTF(),
                              _buildTermsLB(),
                              _buildRegisterBtn(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // /////////////////////////////////////////////////////////////////////////

  Widget _buildTermsLB() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 0.0),
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

  Widget _buildEmailTF() {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
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
            Navigator.pushReplacementNamed(context, "/info");
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

  Widget _buildRegisterBtn() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          try {
            final AuthService _auth = AuthService();
            dynamic rc = await _auth.registerWithEmailAndPassword(
                txtEmail.text, txtPassword.text, null, null);
            Navigator.pushReplacementNamed(context, "/info");
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
        color: primaryColor,
        child: Text(
          'Register',
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
}
