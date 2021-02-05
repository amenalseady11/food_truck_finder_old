import 'package:flutter/material.dart';
import '../colors.dart';

class MySmallIconLabelClosed extends StatelessWidget {
  MySmallIconLabelClosed({
    this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        Icons.watch_later, // near_me, place
        color: skyorangeColor,
        size: 14.0,
      ),
      SizedBox(
        width: 3.0,
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: skyorangeColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  }
}
