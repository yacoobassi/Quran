import 'package:flutter/material.dart';

import '../../Teacher_page/Exams/table.dart';

class review extends StatelessWidget {
  review();
  List<String> columnTitle = [
    "اليوم",
    "التاريخ",
    "رقم الحصة",
    "موضع المراجعة",
    "القسم الأول في الحصة",
    "العلامة",
    "القسم الثاني في الحصة",
  ];
  List cels = [];
  void fillcels() {
    for (int i = 0; i < numcel; i++) {
      cels.add(Text(" "));
    }
  }

  int rowexa = 10;
  int numcol = 7;
  int numcel = 7;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            child: Text(
              "مراجعة امتحان في أجزاء الأحقاف والفرقان",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
        tableExam(columnTitle, rowexa, numcol, numcel),
      ],
    ));
  }
}
