import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../colors.dart';

class MyFormItem extends StatelessWidget {
  MyFormItem({
    this.text,
    this.symbol,
  });

  final String text;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    if (symbol == 'phone') {
      return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 47.0,
        child: TextFormField(
          readOnly: true,
          controller: TextEditingController(text: text),
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            //color: Colors.grey[700],
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 0.0),
            prefixIcon: Icon(
              MdiIcons.phone,
              color: skyorangeColor,
              //size: 38.0,
            ),
          ),
        ),
      );
    } else if (symbol == 'webpage') {
      return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 47.0,
        child: TextFormField(
          readOnly: true,
          controller: TextEditingController(text: text),
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            //color: Colors.grey[700],
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 0.0),
            prefixIcon: Icon(
              MdiIcons.web,
              color: skyorangeColor,
              //size: 38.0,
            ),
          ),
          onTap: () async {
            String url = 'https://' + text;
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
      );
    } else if (symbol == 'instagram') {
      return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 47.0,
        child: TextFormField(
          readOnly: true,
          controller: TextEditingController(text: text),
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            //color: Colors.grey[700],
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 0.0),
            prefixIcon: Icon(
              MdiIcons.instagram,
              color: skyorangeColor,
              //size: 38.0,
            ),
          ),
          onTap: () async {
            String url = 'https://www.instagram.com/' + text;
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
      );
    } else if (symbol == 'facebook') {
      return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 47.0,
        child: TextFormField(
          readOnly: true,
          controller: TextEditingController(text: text),
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            //color: Colors.grey[700],
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 0.0),
            prefixIcon: Icon(
              MdiIcons.facebook,
              color: skyorangeColor,
              //size: 38.0,
            ),
          ),
          onTap: () async {
            String url = 'https://www.facebook.com/' + text;
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 47.0,
        child: TextFormField(
          readOnly: true,
          controller: TextEditingController(text: text),
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            color: Colors.grey[700],
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 0.0),
            prefixIcon: Icon(
              Icons.edit,
              color: skyorangeColor,
            ),
          ),
        ),
      );
    }
  }
}

final kHintTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 1.0,
      //offset: Offset(0, 2),
    ),
  ],
);
