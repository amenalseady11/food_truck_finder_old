import 'package:flutter/material.dart';
import '../colors.dart';

class MyArticle extends StatelessWidget {
  MyArticle({
    this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
      ),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: truckblackColor,
          fontWeight: FontWeight.normal,
          height: 1.6,
          fontSize: 16,
        ),
      ),
    );
  }
}
