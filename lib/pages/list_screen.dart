import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_image/firebase_image.dart';
import '../models/profile_model.dart';
import '../colors.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    final profiles = Provider.of<List<Profile>>(context);

    if (profiles != null) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(color: truckblackColor, height: 3, indent: 10,),
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            return ProfileTile(profile: profiles[index]);
          },
        ),
      );
    } else {
      return Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/undraw_fast_loading.svg',
                semanticsLabel: 'Loading Image',
              ),
            ],
          ));
    }
  }
}

class ProfileTile extends StatelessWidget {
  final Profile profile;
  ProfileTile({this.profile});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      leading: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image(
          image: FirebaseImage(profile.logo),
          fit: BoxFit.fitHeight,
          //width: 100,
          //height: 100,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 3,
        margin: EdgeInsets.all(0),
      ),
      title: Text(
        '${profile.name}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Row(children: [
        Icon(
          Icons.local_dining,
          color: skyorangeColor,
          size: 18.0,
        ),
        SizedBox(width: 5.0,),
        Text(
          '${profile.cuisine}',
          style: TextStyle(fontSize: 18),
        ),
      ]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        print('CLICK from Profile ID  : ' + profile.id);
        Navigator.pushNamed(context, "/detail",
            arguments: {'profile': profile});
      },
    );
  }
}
