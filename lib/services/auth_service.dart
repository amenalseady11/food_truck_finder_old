import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  // sign in anon
  Future signInAnon() async {
    UserCredential result = await _auth.signInAnonymously();
    User user = result.user;
    return user;
  }

  // sign in with email & password
  Future signinWithEmailAndPassword(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    return user;
  }

  // sign out
  Future signOut() async {
    return await _auth.signOut();
  }

  // register with email & password
  Future registerWithEmailAndPassword(
      String email, String password, String phone, String name) async {
    try {
      // create user in firebase
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user;      
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
