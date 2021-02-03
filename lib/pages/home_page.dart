import 'dart:async';

import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_finder/models/userlocation_model.dart';
import 'package:food_truck_finder/services/location_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'list_screen.dart';
import 'map_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';
import '../services/db_foodtrucks_service.dart';
import '../models/foodtruck_model.dart';
import '../colors.dart';

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  List<Widget> listScreens;

  List<ListItem> _dropdownItems = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  @override
  void initState() {
    listScreens = [
      ListScreen(),
      MapScreen(),
      FavoriteScreen(),
      ProfileScreen(),
    ];
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
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
          backgroundColor: Colors.white, //grey[100],
          // flexibleSpace: Image(
          //   image: AssetImage('assets/FTF_Wallpaper2.jpg'),
          //   fit: BoxFit.cover,
          //   isAntiAlias: true,
          // ),
          iconTheme: new IconThemeData(color: truckblackColor),
          elevation: 3,
          centerTitle: true,
          title: Image.asset(
            'assets/FTF_Icon_Transp.png',
            height: 40.0,
          ),

          leading: IconButton(
            icon: Icon(Icons.tune),
            tooltip: "Setup Filter",
            onPressed: () {
              Navigator.pushNamed(context, "/test");
            },
          ),

          actions: [
            IconButton(
              icon: Icon(Icons.info),
              tooltip: "Setup Filter",
              onPressed: () {
                Navigator.pushNamed(context, "/test");
              },
            ),
          ],
        ),
        body: IndexedStack(index: tabIndex, children: listScreens),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: skyorangeColor,
          unselectedItemColor: Colors.grey,
          //selectedFontSize: 14.0,
          //backgroundColor: ,
          elevation: 0,
          unselectedIconTheme: IconThemeData(size: 26),
          selectedIconTheme: IconThemeData(size: 30),
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
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

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }
}
