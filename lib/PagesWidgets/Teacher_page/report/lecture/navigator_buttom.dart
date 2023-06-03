import 'package:flutter/material.dart';

import '../report_info/report_info.dart';
import '../table/grades.dart';
import 'Lecture.dart';

int currentstate = 0;

class nav_bottom extends StatefulWidget {
  Function newReport;
  bool reportPage;
  nav_bottom(this.newReport, this.reportPage);

  @override
  State<nav_bottom> createState() => _nav_bottomState();
}

class _nav_bottomState extends State<nav_bottom> {
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
          label: "معلومات الحصة",
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.table_chart),
          label: " المجموعات",
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pin),
          label: "معلومات التقرير",
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "تسليم التقرير",
          backgroundColor: Colors.green,
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return lecture();
          }));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return grades();
          }));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return report();
          }));
        } else if (index == 3) {
          showDialog(
              context: context,
              builder: (con) {
                return AlertDialog(
                  actions: [
                    ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          if (widget.reportPage) widget.newReport();
                        },
                        child: Text("تأكيد")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("إلغاء")),
                  ],
                  title: Text(
                    "تأكيد التسليم",
                    style: TextStyle(),
                  ),
                  content: Text(
                    "هل أنت متأكد من تسليم التقرير",
                    softWrap: true,
                  ),
                );
              });
        }
        ;

        setState(() {
          currentstate = index;
        });
      },
    );
  }
}
