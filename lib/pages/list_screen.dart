import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      return Column(
        children: <Widget>[
          Container(
            height: 40,
            child: _showFavoriteTitle(),
          ),
          Container(
            height: 100,
            child: _showFavoriteListView(profiles),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: _showNearbyListView(),
            ),
          )
        ],
      );
    }
  }

  Widget _showFavoriteTitle() {
    return Text(
      'My Favorite (0)',
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'OpenSans',
        //fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _showFavoriteListView(List<Profile> items) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          Divider(color: Colors.black, height: 0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ProfileTile(profile: items[index]);
      },
    );
  }

  Widget _showNearbyListView() {
    return Container();
  }

  //   return Container(
  //     height: MediaQuery.of(context).size.height,
  //     width: MediaQuery.of(context).size.width,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         // Text(
  //         //   'My Favorite (0)',
  //         //   style: TextStyle(
  //         //     color: Colors.black,
  //         //     fontFamily: 'OpenSans',
  //         //     //fontSize: 16.0,
  //         //     fontWeight: FontWeight.normal,
  //         //   ),
  //         // ),

  //         // Text(
  //         //   'Nearby (0)',
  //         //   style: TextStyle(
  //         //     color: Colors.black,
  //         //     fontFamily: 'OpenSans',
  //         //     //fontSize: 16.0,
  //         //     fontWeight: FontWeight.normal,
  //         //   ),
  //         // ),

  //         // Text(
  //         //   'Other (0)',
  //         //   style: TextStyle(
  //         //     color: Colors.black,
  //         //     fontFamily: 'OpenSans',
  //         //     //fontSize: 16.0,
  //         //     fontWeight: FontWeight.normal,
  //         //   ),
  //         // ),

  //         ListView.separated(
  //            separatorBuilder: (context, index) =>
  //                Divider(color: Colors.black, height: 0),
  //            itemCount: profiles.length,
  //            itemBuilder: (context, index) {
  //              return ProfileTile(profile: profiles[index]);
  //            },
  //          ),
  //       ],
  //     ),
  //   );
  // } else {
  //   return Container(
  //     child: Text('Empty'),
  //   );
  // }
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
        // Badge(
        //   toAnimate: false,
        //   shape: BadgeShape.square,
        //   badgeColor: truck.open ? Colors.green : Colors.red,
        //   badgeContent: truck.open
        //       ? Text(
        //           'Open',
        //           style: TextStyle(color: Colors.white, fontSize: 12),
        //         )
        //       : Text('Closed',
        //           style: TextStyle(color: Colors.white, fontSize: 12)),
        //   borderRadius: BorderRadius.circular(10),
        // ),
      ]),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        print('CLICK from Profile ID  : ' + profile.id);
        //Navigator.pushNamed(context, "/detail", arguments: {'truck': truck});
      },
    );
  }
}
