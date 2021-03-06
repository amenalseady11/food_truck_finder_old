import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/home_page.dart';
import 'pages/detail/detail_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/profile/profile_edit_page.dart';
import 'services/auth_service.dart';
import 'services/db_foodtrucks_service.dart';
import 'services/location_service.dart';
import 'models/userlocation_model.dart';
import 'models/foodtruck_model.dart';
import 'models/total_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TotalModel()),
      StreamProvider<List<FoodTruck>>.value(
          value: DbFoodTrucksService().foodtrucks),
      StreamProvider<UserLocation>.value(
        value: LocationService().locationStream,
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Food Truck Finder',
        debugShowCheckedModeBanner: false,
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
          // cardTheme: CardTheme(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: const BorderRadius.all(
          //       Radius.circular(20.0),
          //     ),
          //   ),
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
          '/profile': (BuildContext context) => ProfilePage(),
          '/profile_edit': (BuildContext context) => ProfileEditPage(),
        },
      ),
    );
  }
}
