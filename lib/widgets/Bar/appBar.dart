import 'package:badges/badges.dart';
import 'package:badges/src/badge.dart' as badge;
import 'package:flutter/material.dart';

class appbar extends StatefulWidget implements PreferredSizeWidget {
  String title;
  bool width;
  Function show, likes, comments;

  appbar(
      {Key myKey, this.title, this.show, this.likes, this.comments, this.width})
      : super(key: myKey);

  @override
  State<appbar> createState() => _appBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return new Size.fromHeight(50.0);
  }
}

class _appBarState extends State<appbar> {
  int notification_num = 0;
  bool clicked1 = false, clicked2 = false;
  int messege_num = 0, count1 = 0, count2 = 0;
  double circular;

  @override
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
        IconButton(
          icon: badge.Badge(
              position: BadgePosition.topStart(),
              badgeContent: Text("$notification_num"),
              child: Icon(Icons.add_alert)),
          onPressed: () {
            setState(() {
              clicked1 = true;
              if (count2 == 0) clicked2 = false;
              count1++;
              count2 = 0;
              if (count1 == 2) {
                clicked2 = false;
                clicked1 = true;
                count1 = 0;
                widget.likes;
              }
            });
            {
              if (clicked1 && !clicked2) {
                widget.show();
              }
            }
          },
        ),
        GestureDetector(
          child: IconButton(
              icon: badge.Badge(
                  position: BadgePosition.topStart(),
                  badgeContent: Text("$messege_num"),
                  child: Icon(Icons.email)),
              onPressed: () {
                setState(() {
                  clicked2 = true;
                  if (count1 == 0) clicked1 = false;
                  count2++;
                  count1 = 0;
                  if (count2 == 2) {
                    clicked1 = false;
                    clicked2 = true;
                    count2 = 0;
                    widget.comments;
                  }
                });
                if (!clicked1 && clicked2) {
                  widget.show();
                }
              }),
        ),
      ],
      title: Text(
        "${widget.title}",
        textDirection: TextDirection.rtl,
      ),
      backgroundColor: Colors.green,
    );
  }
}
