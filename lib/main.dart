import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/home_page.dart';
import 'pages/detail_page.dart';
import 'pages/test_page.dart';
import 'services/auth_service.dart';
import 'services/db_foodtrucks_service.dart';

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
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.grey,
          primaryColor: Colors.white,
          // accentColor: accentColor,
          backgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // buttonTheme: ButtonThemeData(
          //   minWidth: double.infinity,
          // ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          primaryColor: Colors.black,
          // primaryColor: primaryColor,
          // accentColor: accentColor,
          backgroundColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          //  buttonTheme: ButtonThemeData(
          //    minWidth: double.infinity,
          //  ),
        ),
        themeMode: ThemeMode.system,
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomePage(),
          '/detail': (BuildContext context) => DetailPage(),
          '/test': (BuildContext context) => TestPage(),
        },
      ),
    );
  }
}
