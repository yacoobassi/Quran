import 'package:flutter/material.dart';

import '../../pages/posts.dart';
import '../Bar/drawer.dart';
import '../Bar/notification.dart';
import '../Teacher_page/Exams/table.dart';

class examstu extends StatelessWidget {
  examstu();

  int rowexa = 15, numcol = 3, numcel = 3;
  List<String> collist = [
    "             الامتحان            ",
    "العلامة",
    "التقدير"
  ];
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("الامتحانات"),
      ),
      drawer: drawer(student: true, drawer_width: drawer().drawer_width),
      endDrawer: notification(
        width: screen,
        text: likeORcomment,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 5),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        " علامة آخر امتحان  :  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      child: Text("97.5%"),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Container(
                                      child: Text("المعدل التراكمي    : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    ),
                                    Container(
                                      child: Text("93.5%"),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Text("الامتحان القادم :  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    ),
                                    Container(
                                      child: Text("جزء تبارك"),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      child: Text("تاريخ الامتحان القادم  :  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    ),
                                    Container(
                                      child: Text("7/3/2024"),
                                    ),
                                  ],
                                ),
                              ])),
                      SizedBox(
                        height: 20,
                      ),
                      tableExam(collist, rowexa, numcol, numcel),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
