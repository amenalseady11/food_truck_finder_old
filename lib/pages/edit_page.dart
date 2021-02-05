import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/location_service.dart';
import '../services/db_foodtrucks_service.dart';
import '../models/userlocation_model.dart';
import '../models/foodtruck_model.dart';
import '../colors.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: truckblackColor),
          elevation: 3,
          centerTitle: true,
          title: Image.asset(
            'assets/FTF_Icon_Transp.png',
            height: 40.0,
          ),          
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30.0),
                Text('EDIT PAGE'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}