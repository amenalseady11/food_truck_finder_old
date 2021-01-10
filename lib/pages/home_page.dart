import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'list_screen.dart';
import 'map_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';
import '../models/profile_model.dart';
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
        StreamProvider<List<Profile>>.value(
            value: DbProfilesService().profiles),
      ],
      child: Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: skyorangeColor),
          elevation: 6,
          centerTitle: true,
          title: Text('Food Truck Finder',
              style: TextStyle(color: truckblackColor)),
        ),
        body: IndexedStack(index: tabIndex, children: listScreens),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: skyorangeColor,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 14.0,
          // backgroundColor: ,
          elevation: 6,
          unselectedIconTheme: IconThemeData(size: 18),
          selectedIconTheme: IconThemeData(size: 22),
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storage),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storage),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storage),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
