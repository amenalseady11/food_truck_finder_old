import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import '../colors.dart';

class MyLogo extends StatelessWidget {
  MyLogo({
    this.path,
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
      ),
      child: Image(
        image: FirebaseImage(path),
        fit: BoxFit.fitHeight,
        width: 100,
        height: 100,
      ),
    );
  }
}
