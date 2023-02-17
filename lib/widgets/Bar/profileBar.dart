import 'package:badges/badges.dart';
import 'package:badges/src/badge.dart' as badge;
import 'package:flutter/material.dart';

double opacity = 1;

class profileBar extends StatefulWidget {
  String text, image;

  profileBar({Key myKey, this.text, this.image}) : super(key: myKey);

  @override
  State<profileBar> createState() => _profileBarState();
}

class _profileBarState extends State<profileBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          //                   <--- left side
          color: Colors.grey,
          width: 1.0,
        ))),
        padding: EdgeInsets.all(30),
        height: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            badge.Badge(
              badgeContent: Icon(Icons.edit),
              badgeStyle: BadgeStyle(badgeColor: Colors.white),
              position: BadgePosition.bottomStart(),
              onTap: () {
                setState(() {});
              },
              child: InkWell(
                child: ClipOval(
                    child: Image.asset(
                  "${widget.image}",
                  color: Colors.white.withOpacity(opacity),
                  colorBlendMode: BlendMode.modulate,
                  height: 80.0,
                  width: 80.0,
                  fit: BoxFit.fill,
                )),
                onTap: () {
                  opacity = 0.7;
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${widget.text}",
              style: TextStyle(fontSize: 20),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "  مرحبا بك",
              ),
              Container(
                width: 15,
                height: 15,
                child: Image.asset("images/heart.png"),
              ),
            ]),
            SizedBox(
              height: 8,
            ),
          ],
        ));
  }
}
