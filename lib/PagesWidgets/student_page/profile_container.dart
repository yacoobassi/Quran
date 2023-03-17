import 'package:badges/badges.dart';
import 'package:badges/src/badge.dart' as badge;
import 'package:flutter/material.dart';

import '../../sharedPref.dart';

class profile_container extends StatefulWidget {
  double width;

  profile_container({Key myKey, this.width}) : super(key: myKey);
  @override
  State<profile_container> createState() => _profile_containerState();
}

class _profile_containerState extends State<profile_container> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 80),
        padding: EdgeInsets.only(top: 20),
        width: widget.width,
        height: 170,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          badge.Badge(
            badgeContent: Icon(Icons.edit),
            badgeStyle: BadgeStyle(badgeColor: Colors.white),
            position: BadgePosition.bottomStart(),
            onTap: () {
              setState(() {});
            },
            child: Container(
              child: InkWell(
                child: FutureBuilder(
                  future: Pref.getProfileImage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(snapshot.data),
                        backgroundColor: Colors.transparent,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                onTap: () {},
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          FutureBuilder(
            future: Pref.getUserName(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data,
                  style: TextStyle(fontSize: 20),
                );
              } else {
                return Text("");
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "  مرحبا بك",
              ),
              Container(
                width: 15,
                height: 15,
                child: Image.asset("images/heart.png"),
              ),
            ],
          ),
        ]));
  }
}
