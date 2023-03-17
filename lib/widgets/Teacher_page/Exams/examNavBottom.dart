import 'package:flutter/material.dart';

import '../../../PagesWidgets/Teacher_page/Exams/full_info.dart';
import '../../../PagesWidgets/Teacher_page/Exams/fulltable.dart';
import '../../../PagesWidgets/Teacher_page/Exams/grade.dart';

class bottom_Nav_exam extends StatefulWidget {
  bottom_Nav_exam();

  @override
  State<bottom_Nav_exam> createState() => _bottom_Nav_examState();
}

class _bottom_Nav_examState extends State<bottom_Nav_exam> {
  int currentstate = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.white,
      currentIndex: currentstate,
      selectedItemColor: Colors.orangeAccent,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.green,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "معلومات الامتحان",
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.table_chart),
          label: " العلامات",
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pin),
          label: " التقرير الكامل",
          backgroundColor: Colors.green,
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ful_info();
          }));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return grade();
          }));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return fullTable();
          }));
        }
        ;

        setState(() {
          currentstate = index;
        });
      },
    );
  }
}
