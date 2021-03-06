import 'package:flutter/material.dart';
import '../colors.dart';

class MyCuisine extends StatelessWidget {
  MyCuisine({
    this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 0,
        bottom: 10,
      ),
      child: Text(
        label,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: truckblackColor,
          fontWeight: FontWeight.normal,
          height: 1,
          fontSize: 15,
        ),
      ),
    );
  }
}
