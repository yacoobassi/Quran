import 'package:flutter/material.dart';

import '../../Teacher_page/Exams/table.dart';

class tablesave extends StatelessWidget {
  tablesave();

  List columnTitle = [
    {"title": "رقم الحصة", "value": "num"},
    {"title": "موضع الحفظ", "value": "num"},
    {"title": "موضع المراجعة", "value": "num"}
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
    return Center(
        child:
            tableExam(columnTitle, rowexa, numcol, numcel, null, false, null));
  }
}
