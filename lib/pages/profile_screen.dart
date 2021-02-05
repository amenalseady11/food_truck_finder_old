import 'package:flutter/material.dart';
import 'package:food_truck_finder/colors.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/userlocation_model.dart';
import '../models/foodtruck_model.dart';
import '../services/auth_service.dart';
import '../widgets/mytabtitle_widget.dart';
import '../colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtCuisine = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  bool isTruckRegistrationSwitched = false;

  @override
  Widget build(BuildContext context) {
    // user credentials
    final user = Provider.of<User>(context);
    final userlocation = Provider.of<UserLocation>(context);

    // PROFILE
    if (user != null) {
      // Read foodtrucks list
      final foodtrucks = Provider.of<List<FoodTruck>>(context);

      // Try to find matching foodtruck profile
      FoodTruck foodtruck = null;
      if (foodtrucks != null) {
        foodtruck =
            foodtrucks.firstWhere((item) => item.id == user.uid, orElse: () {
          return null;
        });
      }

      // PROFILE VIEW as VENDOR
      if (foodtruck != null) {
        // Profiles screen
        return Container(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildVendorProfileLB(),
                _buildEmailTF(),
                _buildNameTF(),
                _buildCuisineTF(),
                _buildDescriptionTF(),
                _buildPhoneTF(),
                _buildUpdateBtn(),
                _buildCleanLocationBtn(),
                _buildLogoutBtn(),
                Text('VENDOR PROFILE'),
                Text('GPS: ' +
                    userlocation.latitude.toStringAsFixed(6) +
                    '; ' +
                    userlocation.longitude.toStringAsFixed(6)),
              ],
            ),
          ),
        );
      }
      // PROFILE VIEW as CUSTOMER
      else {
        // Profiles screen
        return Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text('CUSTOMER PROFILE'),
              _buildLogoutBtn(),
              Text('GPS: ' +
                  userlocation.latitude.toStringAsFixed(6) +
                  '; ' +
                  userlocation.longitude.toStringAsFixed(6)),
            ],
          ),
        );
      }
    }
    // LOGIN/REGISTER
    else {
      // Login/Register screen
      return Container(
        padding: EdgeInsets.all(30),
        child: DefaultTabController(
          length: 2, // length of tabs
          initialIndex: 0,
          child: Column(children: <Widget>[
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
                          _buildSwitch(),
                          if (isTruckRegistrationSwitched) _buildPhoneTF(),
                          if (isTruckRegistrationSwitched) _buildNameTF(),
                          _buildRegisterBtn(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
    }
  }

  // /////////////////////////////////////////////////////////////////////////

  Widget _buildVendorProfileLB() {
    return Container(
      margin: EdgeInsets.only(top: 0.0, bottom: 20.0),
      child: Text(
        'Vendor Profile',
        style: TextStyle(
          color: truckblackColor,
          letterSpacing: 1.5,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }

  Widget _buildCustomerProfileLB() {
    return Container(
      margin: EdgeInsets.only(top: 0.0, bottom: 20.0),
      child: Text(
        'Customer Profile',
        style: TextStyle(
          color: truckblackColor,
          letterSpacing: 1.5,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
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

  Widget _buildNameTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
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
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.local_shipping,
            color: Colors.grey[700],
          ),
          hintText: 'Enter foodtruck name',
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
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Colors.grey[700],
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.local_dining,
            color: Colors.grey[700],
          ),
          hintText: 'Enter foodtruck cuisine style',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildDescriptionTF() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      //height: 50.0,
      child: TextFormField(
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
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.description,
            color: Colors.grey[700],
          ),
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
            value: isTruckRegistrationSwitched,
            onChanged: (value) {
              setState(() {
                isTruckRegistrationSwitched = value;
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
                txtEmail.text, txtPassword.text, txtPhone.text, txtName.text);
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

  Widget _buildUpdateBtn() {
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
          'Save Changes',
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

  Widget _buildCleanLocationBtn() {
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
          'Clean Location',
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

// ----------------------------------------------------------------------------
}
