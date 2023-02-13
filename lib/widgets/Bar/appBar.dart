import 'package:Quran/pages/posts.dart';
import 'package:Quran/pages/teacherPage.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class appbar extends StatefulWidget implements PreferredSizeWidget {
  String title;
  Function show;

  appbar({Key myKey, this.title, this.show}) : super(key: myKey);

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
  bool clicked1 = false, clicked2 = false, visible = false;
  int messege_num = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: [
        IconButton(
          icon: Badge(
              position: BadgePosition.topStart(),
              badgeContent: Text("$notification_num"),
              child: Icon(Icons.add_alert)),
          onPressed: () {
            setState(() {
              if (clicked1)
                visible = true;
              else
                visible = false;
              clicked1 = true;
            });
            if (visible) {
              widget.show();
              clicked1 = false;
            }
          },
        ),
        GestureDetector(
          child: IconButton(
            icon: Badge(
                position: BadgePosition.topStart(),
                badgeContent: Text("$messege_num"),
                child: Icon(Icons.email)),
            onPressed: () {
              setState(() {
                if (clicked2)
                  visible = true;
                else
                  visible = false;
                clicked2 = true;
              });
              if (visible) {
                widget.show();
                clicked2 = false;
              }
            },
          ),
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
