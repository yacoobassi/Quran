import 'package:flutter/material.dart';

import '../../../PagesWidgets/student_page/schedule/review.dart';
import '../../../PagesWidgets/student_page/schedule/save.dart';
import '../../../pages/posts.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';
import '../../Teacher_page/Exams/table.dart';
import '../../Teacher_page/report/lecture/dropdown.dart';

class schedule extends StatefulWidget {
  const schedule();

  @override
  State<schedule> createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  var tablechoose;
  var tablechoose1;
  bool checkpress = false;
  bool checkpress1 = false;
  List Part = ["عم", "تبارك", "المجادلة", "الذاريات", "الأحقاف", "الشورى"];

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("الدفتر"),
      ),
      drawer: drawer(
          student: true,
          email: "Yacoobassi8@gmai.com",
          name: "Yacoob assi",
          image: "images/face.jpg",
          drawer_width: drawer().drawer_width),
      endDrawer: notification(
        width: screen,
        text: likeORcomment,
      ),
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
                Container(
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
                        child: droplist(Part, "عم"),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            if (checkpress1 == true) {
                              checkpress1 = false;
                              tablechoose1 = null;
                            }
                            checkpress = !checkpress;
                            if (checkpress == true)
                              tablechoose = tablesave();
                            else {
                              tablechoose = null;
                            }
                          });
                        },
                        child: Text(
                          "جدول الحفظ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            if (checkpress == true) {
                              checkpress = false;
                              tablechoose = null;
                            }
                            checkpress1 = !checkpress1;
                            if (checkpress1 == true)
                              tablechoose1 = review();
                            else {
                              tablechoose1 = null;
                            }
                          });
                        },
                        child: Text(
                          "جدول مراجعة الامتحان",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
                tablechoose != null
                    ? tablesave()
                    : tablechoose1 != null
                        ? review()
                        : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
