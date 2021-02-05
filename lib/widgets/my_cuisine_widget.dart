import 'package:flutter/material.dart';
import '../colors.dart';

class MyCuisine extends StatelessWidget {
  MyCuisine({
    this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      //Icon(
      //  Icons.local_dining, // near_me, place
      //  color: skyorangeColor,
      //  size: 14.0,
      //),
      //SizedBox(
      //  width: 3.0,
      //),
      Text(
        label,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal
            //color: applegreenColor,
            ),
      ),
    ]);
  }
}
