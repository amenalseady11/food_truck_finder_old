import 'package:flutter/material.dart';
import '../colors.dart';

class MySmallIconLabel extends StatelessWidget {
  MySmallIconLabel({
    this.symbol,
    this.label,
    this.open,
  });

  final String symbol;
  final String label;
  final bool open;

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
          width: 3.0,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
      ]);
    }
    if (symbol == 'place') {
      return Row(children: [
        Icon(
          Icons.place,
          color: (open) ? skyorangeColor : Colors.green,
          size: 18.0,
        ),
        SizedBox(
          width: 3.0,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
      ]);
    }
    return null;
  }
}
