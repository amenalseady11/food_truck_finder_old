import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import '../colors.dart';

class MyClosed extends StatelessWidget {
  MyClosed({
    this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Badge(
      padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
      shape: BadgeShape.square,
      badgeColor: Colors.grey[400],
      borderRadius: BorderRadius.circular(4),
      badgeContent:
          Text(label, style: TextStyle(color: Colors.white, fontSize: 13)),
    );

    //Row(children: [
    //Icon(
    //  Icons.watch_later, // near_me, place
    //  color: skyorangeColor,
    //  size: 14.0,
    //),
    //SizedBox(
    //  width: 3.0,
    //),
    //Text(
    //  label,
    //  style: TextStyle(
    //    fontSize: 14,
    //    color: skyorangeColor,
    //    fontWeight: FontWeight.bold,
    //  ),
    //),
    //]);
  }
}
