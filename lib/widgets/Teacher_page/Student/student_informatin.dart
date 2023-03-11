import 'package:flutter/material.dart';

import '../../../pages/posts.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';
import '../Exams/table.dart';

class student_Data extends StatefulWidget {
  student_Data();

  @override
  State<student_Data> createState() => _student_DataState();
}

class _student_DataState extends State<student_Data> {
  List<String> columnTitle1 = [
    "رقم الطالب",
    "رقم تسجيل الطالب",
    "الاسم الرباعي",
    "الصف",
    "المستوى الدراسي",
    "تاريخ الميلاد",
    "رقم جوال الأب",
    "رقم جوال الأم",
    "عنوان السكن",
    "المعدل التراكمي",
  ];
  List cels = [];
  void fillcels() {
    for (int i = 0; i < numcel1; i++) {
      cels.add(Text(" "));
    }
  }

  int rowexa1 = 34;
  int numcol1 = 10;
  int numcel1 = 10;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: drawer(
            student: false,
            email: "Yacoobassi8@gmai.com",
            name: "Yacoob assi",
            image: "images/face.jpg",
            drawer_width: drawer().drawer_width),
        endDrawer: notification(
          width: screen,
          text: likeORcomment,
        ),
        appBar: AppBar(
          title: Text(
            "التقرير الشهري ",
          ),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                        child: tableExam(
                            columnTitle1, rowexa1, numcol1, numcel1))))));
  }
}
