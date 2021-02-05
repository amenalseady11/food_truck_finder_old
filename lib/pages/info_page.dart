import 'package:flutter/material.dart';
import 'package:food_truck_finder/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/location_service.dart';
import '../services/db_foodtrucks_service.dart';
import '../models/userlocation_model.dart';
import '../models/foodtruck_model.dart';
import '../colors.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtCuisine = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    FoodTruck foodtruck;
    final user = Provider.of<User>(context);

    if (user != null) {
      DbFoodTrucksService _fts = DbFoodTrucksService(uid: user.uid);
      _fts.readFoodTruck().then((FoodTruck item) => {
            txtName.text = item.name,
            txtCuisine.text = item.cuisine,
            txtDescription.text = item.description,
            txtPhone.text = item.phone,
          });
    }

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
          actions: [
            (user == null)
                ? IconButton(
                    icon: Icon(Icons.login),
                    tooltip: "Login",
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.logout),
                    tooltip: "Logout",
                    onPressed: () async {
                      try {
                        final AuthService _auth = AuthService();
                        await _auth.signOut();
                        //ackAlert(context);
                      } on FirebaseAuthException catch (e) {
                        //errAlert(context, 'Warning', e.message);
                      } catch (e) {
                        //errAlert(context, 'Error', e.toString());
                      }
                      Navigator.pushReplacementNamed(context, "/home");
                    },
                  ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: (user == null)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        Text('ABOUT'),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildTitleLB(),
                        _buildNameLB(),
                        _buildNameTF(),
                        _buildCuisineLB(),
                        _buildCuisineTF(),
                        _buildDescriptionLB(),
                        _buildDescriptionTF(),
                        _buildPhoneLB(),
                        _buildPhoneTF(),
                      ],
                    )),
        ),
      ),
    );
  }

  Widget _buildTitleLB() {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      alignment: Alignment.topCenter,
      child: Text(
        'FoodTruck Profile',
        style: TextStyle(
          color: sunyellowColor,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    );
  }

  // LABELS

  Widget _buildNameLB() {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      alignment: Alignment.topLeft,
      child: Text(
        'Name',
        style: TextStyle(
          color: truckblackColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildCuisineLB() {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      alignment: Alignment.topLeft,
      child: Text(
        'Cuisine',
        style: TextStyle(
          color: truckblackColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildDescriptionLB() {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      alignment: Alignment.topLeft,
      child: Text(
        'Description',
        style: TextStyle(
          color: truckblackColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildPhoneLB() {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      alignment: Alignment.topLeft,
      child: Text(
        'Phone',
        style: TextStyle(
          color: truckblackColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  // TEXT FIELDS

  Widget _buildNameTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextFormField(
        controller: txtName,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Colors.grey[700],
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14.0),
          hintText: 'Enter foodtruck name',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildCuisineTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextFormField(
        controller: txtCuisine,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Colors.grey[700],
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14.0),
          hintText: 'Enter foodtruck cuisine style',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildDescriptionTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      alignment: Alignment.topLeft,
      decoration: kBoxDecorationStyle,
      height: 220.0,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        controller: txtDescription,
        keyboardType: TextInputType.multiline,
        minLines: 1, //Normal textInputField will be displayed
        maxLines: 15, // when user presses enter it will adapt to it
        style: TextStyle(
          color: Colors.grey[700],
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14.0),
          hintText: 'Enter foodtruck description',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildSwitch() {
    return Container(
      margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
      alignment: Alignment.center,

      //decoration: kBoxDecorationStyle,
      height: 50.0,
      child: Row(
        children: [
          Switch(
            value: isEnabled,
            onChanged: (value) {
              setState(() {
                isEnabled = value;
              });
            },
            activeTrackColor: skyorangeColor,
            //activeColor: skyorangeColor,
          ),
          Text('Register as Food Truck Vendor'),
        ],
      ),
    );
  }

  Widget _buildEmailTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextFormField(
        readOnly: true,
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

  Widget _buildPhoneTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 50.0,
      child: TextFormField(
        controller: txtPhone,
        keyboardType: TextInputType.phone,
        style: TextStyle(
          color: Colors.grey[700],
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.grey[700],
          ),
          hintText: 'Enter phone number',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  // BUTTONS

  Widget _buildLogoutBtn() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          try {
            final AuthService _auth = AuthService();
            await _auth.signOut();
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
          'Log Out',
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

  // STYLES

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
