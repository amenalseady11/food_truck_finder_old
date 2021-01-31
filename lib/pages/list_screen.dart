import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_image/firebase_image.dart';
import '../widgets/mysmalliconlabel_widget.dart';
import '../models/userlocation_model.dart';
import '../models/foodtruck_model.dart';
import '../colors.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    final foodtrucks = Provider.of<List<FoodTruck>>(context);
    final userlocation = Provider.of<UserLocation>(context);

    if (foodtrucks != null) {
      foodtrucks.forEach(
        (item) {
          if (userlocation != null) {
            double latitudeDif =
                (item.latitude - userlocation.latitude) * 111.32;
            double longitudeDif = (item.longitude - userlocation.longitude) *
                40075 *
                cos(item.latitude) /
                360;
            latitudeDif = latitudeDif.abs();
            longitudeDif = longitudeDif.abs();
            item.distance = sqrt(
                (latitudeDif * latitudeDif) + (longitudeDif * longitudeDif));
          } else {
            item.distance = 0;
          }
        },
      );

      foodtrucks.sort((a, b) => a.distance.compareTo(b.distance));

      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[200],
            height: 3,
            indent: 20,
            endIndent: 20,
          ),
          itemCount: foodtrucks.length,
          itemBuilder: (context, index) {
            return FoodTruckTile(foodtruck: foodtrucks[index]);
          },
        ),
      );
    } else {
      return Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/undraw_fast_loading.svg',
                semanticsLabel: 'Loading Image',
              ),
            ],
          ));
    }
  }
}

class FoodTruckTile extends StatelessWidget {
  final FoodTruck foodtruck;
  FoodTruckTile({this.foodtruck});

  @override
  Widget build(BuildContext context) {
    String imgL = 'gs://foodtruckfinder-proj.appspot.com/' +
        foodtruck.id.toString() +
        '_L.jpg';

    return ListTile(
      contentPadding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
      tileColor: Colors.white,
      leading: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image(
          image: FirebaseImage(imgL),
          fit: BoxFit.fitHeight,
          //width: 100,
          //height: 100,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3,
        margin: EdgeInsets.all(0),
      ),
      title: Text(
        '${foodtruck.name}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Row(
        children: [
          MySmallIconLabel(
            symbol: 'cuisine',
            label: foodtruck.cuisine,
          ),
          SizedBox(
            width: 3.0,
          ),
          MySmallIconLabel(
            symbol: 'place',
            label: foodtruck.distance.toStringAsFixed(1) + ' km',
            open: foodtruck.status,
          ),
        ],
      ), //trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        print('CLICK from Profile ID  : ' + foodtruck.id);
        Navigator.pushNamed(context, "/detail",
            arguments: {'foodtruck': foodtruck});
      },
    );
  }
}
