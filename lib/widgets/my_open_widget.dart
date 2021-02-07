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
      padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
      shape: BadgeShape.square,
      badgeColor: skyorangeColor,
      borderRadius: BorderRadius.circular(4),
      badgeContent:
          Text(label, style: TextStyle(color: Colors.white, fontSize: 13)),      
    );
  }
}
