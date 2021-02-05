import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import '../colors.dart';

class MyOpen extends StatelessWidget {
  MyOpen({
    this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Badge(
      toAnimate: true,
      padding: EdgeInsets.only(left: 3, right: 3, top: 1, bottom: 1),
      shape: BadgeShape.square,
      badgeColor: applegreenColor,
      borderRadius: BorderRadius.circular(4),
      badgeContent:
          Text('OPEN', style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}
