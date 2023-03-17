import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/Teacher_page/Exams/table.dart';

import '../../../pages/posts.dart';
import '../../../title.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';
import 'examNavBottom.dart';

List exam = [" ", "جزء عم", "عم وتبارك ", "عم وتبارك والمجادلة"];
List<String> columnTitle = [
  "الترتيب",
  "الطالب",
  "علامة الامتحان",
  "التقدير",
  "علامة الامتحان السابق",
  "خصم التجويد",
  "ملاحظات",
];

int rowexa = 30;
int numcol = 7;
int numcel = 7;

class fullTable extends StatefulWidget {
  fullTable();

  @override
  State<fullTable> createState() => _fullTableState();
}

class _fullTableState extends State<fullTable> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: drawer(student: false, drawer_width: drawer().drawer_width),
        endDrawer: notification(
          width: screen,
          text: likeORcomment,
        ),
        appBar: AppBar(
          title: Text(
            "الامتحانات ",
          ),
        ),
        bottomNavigationBar: bottom_Nav_exam(),
        body: Center(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    title("أسماء المتقدمين للامتحان حسب النتيجة", "", "", "",
                        400),
                    SizedBox(
                      height: 10,
                    ),
                    tableExam(
                      columnTitle,
                      rowexa,
                      numcol,
                      numcel,
                    )
                  ],
                )))));
  }
}
