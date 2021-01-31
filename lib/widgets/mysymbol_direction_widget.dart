import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../colors.dart';

class MySymbolDirection extends StatelessWidget {
  MySymbolDirection({
    this.symbol,
  });

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(
            MdiIcons.directions,
            color: truckblackColor,
            size: 38.0,
          ),
          Text(
            'Direction',
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
