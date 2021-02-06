import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import '../colors.dart';

class MyImages extends StatelessWidget {
  MyImages({
    this.list,
  });

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          disableCenter: true,
          enlargeCenterPage: true,
          pageSnapping: true,
          //enlargeStrategy: CenterPageEnlargeStrategy.height
        ),
        items: list
            .map(
              (item) => Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                  image: FirebaseImage(item),
                  fit: BoxFit.cover,
                  isAntiAlias: true,
                  // width: ,
                  // height: 80,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3,
                margin: EdgeInsets.all(5),
              ),
            )
            .toList(),
      ),
    );
  }
}
