import 'package:flutter/material.dart';

import 'full_info.dart';
import 'fulltable.dart';
import 'grade.dart';

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
          label: "العلامات",
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pin),
          label: "التقرير الكامل",
          backgroundColor: Colors.green,
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ful_info()),
            (route) => route
                .isFirst, // Remove all previous routes except the first one
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => grade()),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => fullTable()),
          );
        }

        setState(() {
          currentstate = index;
        });
      },
    );
  }
}
