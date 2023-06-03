import 'package:flutter/material.dart';

import '../../Bar/drawer.dart';
import '../../Teacher_page/report/lecture/dropdown.dart';
import 'navbottom.dart';

class schedule extends StatefulWidget {
  const schedule();

  @override
  State<schedule> createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
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
