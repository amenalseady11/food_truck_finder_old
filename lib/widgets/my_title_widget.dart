import 'package:flutter/material.dart';
import '../colors.dart';

class MyTitle extends StatelessWidget {
  MyTitle({
    this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 0,
        bottom: 10,
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: truckblackColor,
          fontWeight: FontWeight.bold,
          height: 1,
          fontSize: 27,
        ),
      ),
    );
  }
}
