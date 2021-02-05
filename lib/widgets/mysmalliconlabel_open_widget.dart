import 'package:flutter/material.dart';
import '../colors.dart';

class MySmallIconLabelOpen extends StatelessWidget {
  MySmallIconLabelOpen({
    this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        Icons.watch_later, // near_me, place
        color: applegreenColor,
        size: 14.0,
      ),
      SizedBox(
        width: 3.0,
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: applegreenColor,
        ),
      ),
    ]);
  }
}
