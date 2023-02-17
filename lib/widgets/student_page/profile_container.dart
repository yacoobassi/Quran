import 'package:badges/badges.dart';
import 'package:badges/src/badge.dart' as badge;
import 'package:flutter/material.dart';

class profile_container extends StatefulWidget {
  double width;
  String name;
  profile_container({Key myKey, this.width, this.name}) : super(key: myKey);
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
                child: ClipOval(
                    child: Image.asset(
                  "images/face.jpg",
                  color: Colors.white.withOpacity(1),
                  colorBlendMode: BlendMode.modulate,
                  height: 70.0,
                  width: 70.0,
                  fit: BoxFit.fill,
                )),
                onTap: () {},
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${widget.name}",
            style: TextStyle(fontSize: 20),
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
