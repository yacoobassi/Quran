import 'package:badges/badges.dart';
import 'package:badges/src/badge.dart' as badge;
import 'package:flutter/material.dart';
import 'package:test_ro_run/User/Data.dart';

class appbar extends StatefulWidget implements PreferredSizeWidget {
  String title;
  bool width;
  Function show, likes, comments;
  double opacity;

  appbar(
      {Key myKey,
      this.title,
      this.show,
      this.likes,
      this.comments,
      this.width,
      this.opacity})
      : super(key: myKey);

  @override
  State<appbar> createState() => _appBarState();

  @override
  Size get preferredSize {
    return new Size.fromHeight(50.0);
  }
}

class _appBarState extends State<appbar> {
  int notification_num = 0;
  bool clicked1 = false, clicked2 = false, showBage = false;
  int badgenum = 0, count1 = 0, count2 = 0;
  double circular;

  Widget build(BuildContext context) {
    circular = widget.width ? 30 : 0;

    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(circular),
        ),
      ),
      centerTitle: true,
      actions: [
        // IconButton(
        //   icon: badge.Badge(
        //       badgeStyle: BadgeStyle(
        //           badgeColor: Colors.red.withOpacity(widget.opacity)),
        //       position: BadgePosition.topStart(),
        //       badgeContent: Text("$notification_num"),
        //       child: Icon(Icons.add_alert)),
        //   onPressed: widget.opacity != 1
        //       ? null
        //       : () {
        //           widget.show("باضافة منشور");
        //         },
        // ),
        IconButton(
            icon: ValueListenableBuilder(
              valueListenable: Data.badgeCount,
              builder: (BuildContext context, int value, Widget child) {
                return Container(
                  child: badge.Badge(
                      showBadge: value > 0,
                      badgeStyle: BadgeStyle(
                          badgeColor: Colors.red.withOpacity(widget.opacity)),
                      position: BadgePosition.topStart(),
                      badgeContent: Text("${value}"),
                      child: Icon(Icons.email)),
                );
              },
            ),
            onPressed: () {
              Data.badgeCount.value = 0;
              showBage = false;

              widget.show("بارسال رسالة");
            }),
      ],
      title: Text(
        "${widget.title}",
        textDirection: TextDirection.rtl,
      ),
      backgroundColor: Colors.green.withOpacity(widget.opacity),
    );
  }
}
