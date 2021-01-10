import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/home_page.dart';
import 'services/auth_service.dart';
import 'services/db_profiles_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp()
      //MultiProvider(
      //  providers: [ChangeNotifierProvider(create: (_) => Gps())],
      //  child: MyApp(),
      //),
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Food Truck Finder',
        //theme: ThemeData(
        //  brightness: Brightness.light,
        //  //primaryColor: primaryColor,
        //  //accentColor: accentColor,
        //  //backgroundColor: backgroundColor,
        //  visualDensity: VisualDensity.adaptivePlatformDensity,
        //  buttonTheme: ButtonThemeData(
        //    minWidth: double.infinity,
        //  ),
        //),
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomePage(),
          //'/profile': (BuildContext context) => ProfilesScreen(),
        },
      ),
    );
  }
}
