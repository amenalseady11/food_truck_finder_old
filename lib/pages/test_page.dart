import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_image/firebase_image.dart';
import '../colors.dart';
import '../models/foodtruck_model.dart';
import '../services/auth_service.dart';
import '../services/db_foodtrucks_service.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage('assets/FTF_Wallpaper2.jpg'),
          fit: BoxFit.cover,
          isAntiAlias: true,
        ),
        backgroundColor: Colors.transparent,
        iconTheme: new IconThemeData(color: truckblackColor),
        elevation: 3,
        centerTitle: true,
        title: Image.asset(
          'assets/FTF_Icon_Transp.png',
          height: 45.0,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCreateBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateBtn() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          try {
            _testCreate(context);
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
          'Create DB Data',
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

  // =====  F U N C T I O N S  =====

  void _testLogin(BuildContext context) async {
    final AuthService _auth = AuthService();
    dynamic result =
        await _auth.signinWithEmailAndPassword('ferko@gmail.com', '123456');
    print('RESULT: $result');
  }

  void _testLogout(BuildContext context) async {
    final AuthService _auth = AuthService();
    dynamic result = await _auth.signOut();
    print('RESULT: $result');
  }

  void _testCreate(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final DbFoodTrucksService _con = DbFoodTrucksService(uid: user.uid);
    dynamic result = await _con.createFoodTruck(
      'Test Foodtruck',
    );
    print('RESULT: $result');
  }

  // =====  H E L P E R S  =====

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
