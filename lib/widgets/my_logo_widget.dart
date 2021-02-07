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
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image(
        image: FirebaseImage(path),
        fit: BoxFit.fitHeight,
        width: 80,
        height: 80,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      margin: EdgeInsets.only(bottom: 20),
    );
  }
}
