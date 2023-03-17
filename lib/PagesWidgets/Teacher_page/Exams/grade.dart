import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/Teacher_page/Exams/table.dart';

import '../../../pages/posts.dart';
import '../../../title.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';
import 'examNavBottom.dart';

class grade extends StatelessWidget {
  grade();

  @override
  Widget build(BuildContext context) {
    List<String> columnTitle = [
      "الترتيب",
      "الطالب",
      "علامة الامتحان",
      "التقدير"
    ];
    List cels = [
      TextField(
        enabled: false,
      ),
      TextField(
        enabled: false,
      ),
      TextField(
        enabled: false,
      ),
      TextField(
        enabled: false,
      )
    ];
    int rowexa = 30;
    int numcol = 4;
    int numcel = 4;
    List lg = [TextField()];
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
        body: SingleChildScrollView(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  title("العلامات", "", "", "", 200),
                  tableExam(columnTitle, rowexa, numcol, numcel)
                ],
              ),
            ),
          ),
        ));
  }
}
