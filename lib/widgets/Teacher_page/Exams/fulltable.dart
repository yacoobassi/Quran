import 'package:Quran/widgets/Teacher_page/Exams/examNavBottom.dart';
import 'package:Quran/widgets/Teacher_page/Exams/table.dart';
import 'package:Quran/widgets/Teacher_page/Exams/title.dart';
import 'package:Quran/widgets/Teacher_page/report/lecture/dropdown.dart';
import 'package:flutter/material.dart';

import '../../../pages/posts.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';

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
                    title("أسماء المتقدمين للامتحان حسب النتيجة", 400),
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
