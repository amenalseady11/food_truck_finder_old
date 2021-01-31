import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../colors.dart';

class MySymbolHeart extends StatelessWidget {
  MySymbolHeart({
    this.symbol,
  });

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(
            MdiIcons.heartOutline,
            color: truckblackColor,
            size: 38.0,
          ),
          Text(
            'Favourite',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
