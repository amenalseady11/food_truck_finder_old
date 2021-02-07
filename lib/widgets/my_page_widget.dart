import 'package:flutter/material.dart';
import '../colors.dart';

class MyPage extends StatelessWidget {
  MyPage({
    this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 15,
      ),
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: truckblackColor,
          fontWeight: FontWeight.bold,
          height: 1,
          fontSize: 28,
        ),
      ),
    );
  }
}
