import 'package:flutter/material.dart';
import '../colors.dart';

class MyLabel extends StatelessWidget {
  MyLabel({
    this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: truckblackColor,
          fontWeight: FontWeight.bold,
          height: 1,
          fontSize: 22,
        ),
      ),
    );
  }
}
