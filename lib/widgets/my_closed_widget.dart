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
      toAnimate: true,
      padding: EdgeInsets.only(left: 3, right: 3, top: 1, bottom: 1),
      shape: BadgeShape.square,
      badgeColor: skyorangeColor,
      borderRadius: BorderRadius.circular(4),
      badgeContent:
          Text('CLOSED', style: TextStyle(color: Colors.white, fontSize: 12)),
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
