import 'package:Quran/widgets/Teacher_page/Exams/examNavBottom.dart';
import 'package:Quran/widgets/Teacher_page/Exams/table.dart';
import 'package:Quran/widgets/Teacher_page/Exams/title.dart';
import 'package:flutter/material.dart';

import '../../../pages/posts.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';

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
    List cels = [TextField(enabled: false,),TextField(enabled: false,),TextField(enabled: false,),TextField(enabled: false,)];
    int rowexa = 30;
    int numcol = 4;
    int numcel = 4;
List lg=[TextField()];
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
        body: SingleChildScrollView(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  title("العلامات", 200),
                  tableExam(columnTitle, rowexa, numcol, numcel)
                ],
              ),
            ),
          ),
        ));
  }
}
