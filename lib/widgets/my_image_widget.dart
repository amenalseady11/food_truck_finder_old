import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import '../colors.dart';

class MyImage extends StatelessWidget {
  MyImage({
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
        //width: 80,
        height: 150,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 1,
      //margin: EdgeInsets.only(bottom: 20),
    );
  }
}
