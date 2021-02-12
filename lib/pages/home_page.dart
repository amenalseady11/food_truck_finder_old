import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'list/list_screen.dart';
import 'map/map_screen.dart';
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
  List<Widget> listAppBars;
  List<Widget> listBodies;

  @override
  void initState() {
    // Define AppBards
    listAppBars = [
      // (index = 0) MAP page
      AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: truckblackColor),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 65, //75,
        leadingWidth: 80,
        leading: Container(
          padding: EdgeInsets.only(left: 20, right: 0, top: 0, bottom: 0),
          child: Image.asset('assets/FTF_Icon_Transp.png', height: 60.0),
        ),
        title: Consumer<TotalModel>(
          builder: (context, total, child) {
            return Text('${total.total} open now',
                style: TextStyle(
                    color: truckblackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.account),
            tooltip: "Profile",
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),
        ],
      ),
      // (index = 1) LIST page
      AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: truckblackColor),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 65, //75,
        leadingWidth: 80,
        leading: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 0,
            top: 0,
            bottom: 0,
          ),
          child: Image.asset(
            'assets/FTF_Icon_Transp.png',
            height: 60.0,
          ),
        ),

        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       MdiIcons.swapVertical,
        //       color: skyorangeColor,
        //     ),
        //     tooltip: "Filter",
        //     onPressed: () {
        //       Navigator.pushNamed(context, "/filter");
        //     },
        //   ),
        // ],
      ),
    ];
    // Defince Bodies
    listBodies = [
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
      appBar: listAppBars[tabIndex],
      body: IndexedStack(index: tabIndex, children: listBodies),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: skyorangeColor,
        unselectedItemColor: truckblackColor,
        elevation: 3,
        unselectedIconTheme: IconThemeData(size: 26),
        selectedIconTheme: IconThemeData(size: 28),
        backgroundColor: Colors.white,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
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
