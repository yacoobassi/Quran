import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

Widget appBar(String title) {
  var notification_num = 0;
  var messege_num = 0;
  return AppBar(
    centerTitle: true,
    actions: [
      IconButton(
        icon: Badge(
            position: BadgePosition.topStart(),
            badgeContent: Text("$notification_num"),
            child: Icon(Icons.add_alert)),
        onPressed: () {},
      ),
      IconButton(
        icon: Badge(
            position: BadgePosition.topStart(),
            badgeContent: Text("$messege_num"),
            child: Icon(Icons.email)),
        onPressed: () {},
      ),
    ],
    title: Text(
      "$title",
      textDirection: TextDirection.rtl,
    ),
    backgroundColor: Colors.green,
  );
}
