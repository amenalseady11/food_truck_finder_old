import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_screen.dart';
import 'map_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';
import '../services/db_profiles_service.dart';
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
          //backgroundColor: Colors.red,
          iconTheme: new IconThemeData(color: skyorangeColor),
          elevation: 3,
          centerTitle: true,
          title: Image.asset('assets/FTF_Icon_Transp.png', height: 45.0,),
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
              icon: Icon(Icons.list),
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
