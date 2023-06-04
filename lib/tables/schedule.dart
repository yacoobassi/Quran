import 'package:flutter/material.dart';

import '../PagesWidgets/Bar/drawer.dart';
import '../PagesWidgets/Teacher_page/report/lecture/dropdown.dart';
import '../PagesWidgets/student_page/schedule/navbottom.dart';

class scheduleteacher extends StatefulWidget {
  const scheduleteacher();

  @override
  State<scheduleteacher> createState() => _scheduleteacherState();
}

class _scheduleteacherState extends State<scheduleteacher> {
  List Part = ["القصص", "تبارك", "المجادلة", "الذاريات", "الأحقاف", "الشورى"];

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: nav_bottomsave(),
      appBar: AppBar(
        title: Text("جداول الحفظ "),
      ),
      drawer: drawer(student: false, drawer_width: drawer().drawer_width),
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
                    "images/save2.gif",
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
