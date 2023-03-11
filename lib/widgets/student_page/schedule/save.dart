import 'package:Quran/widgets/Teacher_page/Exams/table.dart';
import 'package:flutter/material.dart';

class tablesave extends StatelessWidget {
  tablesave();

  List<String> columnTitle = [
    "رقم الحصة",
    "موضع الحفظ",
    "موضع المراجعة",
  ];
  List cels = [];
  void fillcels() {
    for (int i = 0; i < numcel; i++) {
      cels.add(Text(" "));
    }
  }

  int rowexa = 20;
  int numcol = 3;
  int numcel = 3;
  @override
  Widget build(BuildContext context) {
    return Center(child: tableExam(columnTitle, rowexa, numcol, numcel));
  }
}
