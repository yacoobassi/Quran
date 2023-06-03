import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/student_page/schedule/review.dart';

import '../../../pages/posts.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';
import '../../Teacher_page/report/lecture/dropdown.dart';
import 'navbottom.dart';

class review extends StatefulWidget {
  const review();

  @override
  State<review> createState() => _reviewState();
}

class _reviewState extends State<review> {
  List Part = ["القصص", "تبارك", "المجادلة", "الذاريات", "الأحقاف", "الشورى"];

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: nav_bottomsave(),
      appBar: AppBar(
        title: Text("جداول الحفظ "),
      ),
      drawer: drawer(student: true, drawer_width: drawer().drawer_width),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "الجزء :",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          child: droplist(Part, "القصص", null),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  height: 600,
                  child: Image.asset(
                    "images/save1.gif",
                    width: 400,
                    height: 600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
