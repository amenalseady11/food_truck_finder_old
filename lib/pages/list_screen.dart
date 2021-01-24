import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_image/firebase_image.dart';
import '../widgets/mysmalliconlabel_widget.dart';
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

    if (foodtrucks != null) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: truckblackColor,
            height: 3,
            indent: 10,
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
      contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 3,
        margin: EdgeInsets.all(0),
      ),
      title: Text(
        '${foodtruck.name}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: MySmallIconLabel(
        symbol: 'cuisine',
        label: foodtruck.cuisine,
      ),
      //trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        print('CLICK from Profile ID  : ' + foodtruck.id);
        Navigator.pushNamed(context, "/detail",
            arguments: {'foodtruck': foodtruck});
      },
    );
  }
}
