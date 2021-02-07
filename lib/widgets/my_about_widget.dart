import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../colors.dart';

class MyAbout extends StatelessWidget {
  MyAbout();

  final String slogan = 'Find the Best Foodtrucks Around!';

  final String text =
      'Download the app to your iPhone or Android. This is the best way to find foodtrucks in your area. You’ll be amazed at all the food you’ll find that you never knew existed or could never find when you wanted to.';

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 0,
        bottom: 0,
      ),
      child: Column(
        children: [
          // --- HEADER ---
          Container(
            padding: EdgeInsets.only(top: 0, bottom: 30),
            child: Image.asset('assets/FTF_Icon_Transp.png', height: 70.0),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: 0,
              bottom: 20,
            ),
            child: Text(
              'Food Truck Finder',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: truckblackColor,
                fontWeight: FontWeight.bold,
                height: 1,
                fontSize: 27,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: 0,
              bottom: 20,
            ),
            child: Text(
              slogan,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: truckblackColor,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                height: 1,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: truckblackColor,
              fontWeight: FontWeight.normal,
              //fontStyle: FontStyle.italic,
              height: 1.5,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                MdiIcons.apple,
                color: truckblackColor,
                size: 35.0,
              ),
              Icon(
                MdiIcons.googlePlay,
                color: truckblackColor,
                size: 35.0,
              ),
              Icon(
                MdiIcons.facebook,
                color: truckblackColor,
                size: 35.0,
              ),
              Icon(
                MdiIcons.instagram,
                color: truckblackColor,
                size: 35.0,
              ),
            ],
          ),
          SizedBox(height: 30),
          // Email contact
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: 0,
              bottom: 10,
            ),
            child: Text(
              'contact@foodtruckfinder.eu',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: truckblackColor,
                fontWeight: FontWeight.normal,
                height: 1,
                fontSize: 15,
              ),
            ),
          ),
          // Webpage contact
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: 0,
              bottom: 20,
            ),
            child: Text(
              'www.foodtruckfinder.eu',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: truckblackColor,
                fontWeight: FontWeight.normal,
                height: 1,
                fontSize: 15,
              ),
            ),
          ),
          // Company
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
            ),
            child: Text(
              '(c) 2017-2021 Blue Software s.r.o. Czech Republic',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: truckblackColor,
                fontWeight: FontWeight.normal,
                height: 1,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
