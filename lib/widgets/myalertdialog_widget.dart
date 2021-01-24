import 'package:flutter/material.dart';
import '../colors.dart';

class MyAlertDialog extends StatelessWidget {
  MyAlertDialog({
    this.title,
    this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('$message'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Continue',
            style: TextStyle(
              color: skyorangeColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
