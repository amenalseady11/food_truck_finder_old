import 'package:flutter/material.dart';
import 'package:food_truck_finder/models/userlocation_model.dart';
import 'package:food_truck_finder/services/location_service.dart';
import 'package:provider/provider.dart';
import 'list_screen.dart';
import 'map_screen.dart';
import '../services/db_foodtrucks_service.dart';
import '../models/foodtruck_model.dart';
import '../models/total_model.dart';
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

  @override
  void initState() {
    listScreens = [
      MapScreen(),
      ListScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final foodtrucks = Provider.of<List<FoodTruck>>(context);
    final total = Provider.of<TotalModel>(context);

    if (foodtrucks != null) {
      total.reset();
      foodtrucks.forEach(
        (item) {
          if (item.open) {
            total.increment();
          }
        },
      );
    }

    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white, //grey[100],
        iconTheme: new IconThemeData(color: truckblackColor),
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 60, //75,
        leadingWidth: 70,
        leading: Container(
          padding: EdgeInsets.only(left: 20, right: 0, top: 0, bottom: 0),
          child: Image.asset(
            'assets/FTF_Icon_Transp.png',
            height: 40.0,
          ),
        ),

        title: Column(
          children: [
            //Image.asset(
            //  'assets/FTF_Icon_Transp.png',
            //  height: 38.0,
            //),
            Consumer<TotalModel>(
              builder: (context, total, child) {
                return Text(
                  '${total.total} open now',
                  style: TextStyle(
                    color: truckblackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            tooltip: "Info",
            onPressed: () {
              Navigator.pushNamed(context, "/info");
            },
          ),
        ],
      ),
      body: IndexedStack(index: tabIndex, children: listScreens),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: skyorangeColor,
        unselectedItemColor: truckblackColor,
        elevation: 3,
        unselectedIconTheme: IconThemeData(size: 22),
        selectedIconTheme: IconThemeData(size: 28),
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
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'List',
          ),
        ],
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
