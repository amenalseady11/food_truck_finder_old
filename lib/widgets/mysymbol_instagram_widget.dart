import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../colors.dart';

class MySymbolInstagram extends StatelessWidget {
  MySymbolInstagram({
    this.symbol,
  });

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(
            MdiIcons.instagram,
            color: truckblackColor,
            size: 38.0,
          ),
          Text(
            'Instagram',
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
