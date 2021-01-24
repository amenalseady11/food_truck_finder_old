import 'package:flutter/material.dart';

class MyTabTitle extends StatelessWidget {
  MyTabTitle({
    this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
