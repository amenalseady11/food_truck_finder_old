import 'package:flutter/material.dart';
import '../colors.dart';

class MySmallIconLabel extends StatelessWidget {
  MySmallIconLabel({
    this.symbol,
    this.label,
  });

  final String symbol;
  final String label;

  @override
  Widget build(BuildContext context) {
    if (symbol == 'cuisine') {
      return Row(children: [
        Icon(
          Icons.local_dining,
          color: skyorangeColor,
          size: 18.0,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
      ]);
    }
    return null;
  }
}
