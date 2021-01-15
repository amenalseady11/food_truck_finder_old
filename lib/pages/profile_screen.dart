import 'package:flutter/material.dart';
import 'package:food_truck_finder/colors.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/auth_service.dart';
import '../colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        child: Column(
          children: [
            _buildLogoutBtn(),
          ],
        ),
      );
    } else {
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
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  // --- LOGIN part ---
                  Container(
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
                  // --- REGISTER part ---
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30),
                        _buildEmailTF(),
                        _buildPasswordTF(),
                        _buildRegisterBtn(),
                      ],
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
      margin: EdgeInsets.only(top: 20.0),
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
      margin: EdgeInsets.only(top: 20.0),
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
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          try {
            final AuthService _auth = AuthService();
            dynamic rc = await _auth.registerWithEmailAndPassword(
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
