import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_truck_finder/models/userlocation_model.dart';
import 'package:food_truck_finder/services/location_service.dart';
import 'package:provider/provider.dart';
import 'list_screen.dart';
import 'map_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';
import '../services/db_foodtrucks_service.dart';
import '../models/foodtruck_model.dart';
import '../colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  List<Widget> listScreens;

  @override
  void initState() {
    listScreens = [
      ListScreen(),
      MapScreen(),
      FavoriteScreen(),
      ProfileScreen(),
    ];
    super.initState();
  }

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
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          //backgroundColor: Colors.red,
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
          leading: IconButton(
            icon: Icon(Icons.adb),
            tooltip: "Testing",
            onPressed: () {
              Navigator.pushNamed(context, "/test");
            },
          ),
        ),
        body: IndexedStack(index: tabIndex, children: listScreens),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: skyorangeColor,
          unselectedItemColor: Colors.grey,
          //selectedFontSize: 14.0,
          //backgroundColor: ,
          elevation: 5,
          unselectedIconTheme: IconThemeData(size: 26),
          selectedIconTheme: IconThemeData(size: 30),
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), // local_shipping
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
