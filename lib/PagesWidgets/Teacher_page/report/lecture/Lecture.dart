import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../pages/posts.dart';

import '../../../Bar/drawer.dart';
import '../../../Bar/notification.dart';
import '../table/grades.dart';
import 'dropdown.dart';
import 'navigator_buttom.dart';

DateTime date = DateTime.now();
var selectedday = "السبت";
var selectedPart = "عم";

final tabs = [grades(), lecture()];

String Titlerow;
List days = [
  "السبت",
  "الأحد",
  "الاثنين",
  "الثلاثاء",
  "الأربعاء}",
  "الخميس",
  "الجمعة"
];
List Part = ["عم", "تبارك", "المجادلة", "الذاريات", "الأحقاف", "الشورى"];
bool check = false;
bool check1 = true;
DateTime timest = DateTime.utc(000);
DateTime timeend = DateTime.utc(000);

class lecture extends StatefulWidget {
  @override
  State<lecture> createState() => _lectureState();
}

class _lectureState extends State<lecture> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: drawer(student: false, drawer_width: drawer().drawer_width),
        endDrawer: notification(
          width: screen,
          text: likeORcomment,
        ),
        appBar: AppBar(
          title: Text(
            "التقرير الشهري ",
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: 70,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.green),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  "معلومات الحصة",
                  style: TextStyle(fontSize: 25),
                ),
                alignment: Alignment.center,
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 700,
                alignment: Alignment.center,
                child: DataTable(
                    border: TableBorder(
                      bottom: BorderSide(color: Colors.green),
                      top: BorderSide(color: Colors.green),
                      horizontalInside: BorderSide(
                          color: Colors.green, style: BorderStyle.solid),
                    ),
                    columns: [
                      DataColumn(label: Text("العناوين")),
                      DataColumn(label: Text("المحتوى")),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text("اليوم")),
                        DataCell(droplist(days, selectedday)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("التاريخ")),
                        DataCell(
                            Text("${date.year}/${date.month}/${date.day} ")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("رقم الحصة")),
                        DataCell(TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("الجزء")),
                        DataCell(droplist(Part, selectedPart)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("موضع الحفظ")),
                        DataCell(TextField(
                          decoration: InputDecoration(hintText: "..........."),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("موضع المراجعة")),
                        DataCell(TextField(
                          decoration: InputDecoration(hintText: "..........."),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("مادة التجويد")),
                        DataCell(TextField(
                          decoration: InputDecoration(hintText: "..........."),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("حضور المعلم")),
                        DataCell(Checkbox(
                          visualDensity: VisualDensity.standard,
                          onChanged: (val) {
                            setState(() {
                              check = !check;
                            });
                          },
                          value: check,
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("موعد بداية الحصة")),
                        DataCell(ElevatedButton(
                            onPressed: () {
                              setState(() {
                                timest = date;
                              });
                            },
                            child:
                                Text("${timest.hour}:${timest.minute}  إبدأ"))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("موعد نهاية الحصة")),
                        DataCell(ElevatedButton(
                            onPressed: () {
                              setState(() {
                                timeend = date;
                              });
                            },
                            child: Text(
                                "${timeend.hour}:${timeend.minute}  انهي"))),
                      ]),
                    ]),
              ),
            ]),
          ),
        ),
        bottomNavigationBar: nav_bottom());
  }
}
