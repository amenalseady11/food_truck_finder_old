import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/profile_model.dart';

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
              Divider(color: Colors.black, height: 0),
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
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Color(0xff888888),
        //backgroundImage: FirebaseImage(truck.logo),
      ),
      title: Text(
        '${profile.name}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Row(children: [
        Text(
          '${profile.cuisine}',
          style: TextStyle(fontSize: 16),
        ),
      ]),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        print('CLICK from Profile ID  : ' + profile.id);
        //Navigator.pushNamed(context, "/detail", arguments: {'truck': truck});
      },
    );
  }
}
