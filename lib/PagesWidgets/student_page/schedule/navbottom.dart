import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/student_page/schedule/review.dart';

import 'package:test_ro_run/PagesWidgets/student_page/schedule/schedule.dart';

int currentstate = 0;

class nav_bottomsave extends StatefulWidget {
  nav_bottomsave();

  @override
  State<nav_bottomsave> createState() => _nav_bottomsaveState();
}

class _nav_bottomsaveState extends State<nav_bottomsave> {
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
          label: "جدول الحفظ",
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.table_chart),
          label: "جدول مراجعة الامتحان",
          backgroundColor: Colors.green,
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return schedule();
          }));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return review();
          }));
        }

        setState(() {
          currentstate = index;
        });
      },
    );
  }
}
