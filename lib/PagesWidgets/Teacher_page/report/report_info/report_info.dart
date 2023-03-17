import 'package:flutter/material.dart';

import '../../../../pages/posts.dart';
import '../../../Bar/drawer.dart';
import '../../../Bar/notification.dart';
import '../lecture/dropdown.dart';
import '../lecture/navigator_buttom.dart';
import 'Reportbottom.dart';

List days = [" ", "{أحد,ثلاثاء,خميس} ", "{سبت,اثنين,أربعاء}"];
List quranCheck = [" ", "لم يحضروها ", "أحضروها"];
bool checks = false;

class report extends StatefulWidget {
  const report();

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  DateTime date = DateTime.now();
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
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
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
                        "معلومات التقرير",
                        style: TextStyle(fontSize: 25),
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 430,
                      alignment: Alignment.center,
                      child: DataTable(
                          border: TableBorder(
                            bottom: BorderSide(color: Colors.green),
                            top: BorderSide(color: Colors.green),
                            horizontalInside: BorderSide(
                                color: Colors.green, style: BorderStyle.solid),
                          ),
                          columns: [
                            DataColumn(label: Text("  المركز")),
                            DataColumn(label: Text("بلاطة البلد")),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(" الفوج")),
                              DataCell(Text("(19)")),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(" عدد الطلاب: رسميون ")),
                              DataCell(Text("(32)")),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("الأستاذ")),
                              DataCell(Text("يعقوب عاصي")),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(" الأستاذ المساعد")),
                              DataCell(Text("صائب شاكر")),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("الشهر/العام")),
                              DataCell(Text("${date.month}/${date.year}")),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("  عدد أيام دوام الدورة الفعلي")),
                              DataCell(TextField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(hintText: "..........."),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("أيام دوام الشهر القادم ")),
                              DataCell(droplist(days, " ")),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("ساعة دوام الشهر القادم")),
                              DataCell(TextField(
                                decoration:
                                    InputDecoration(hintText: "..........."),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("  تفقد المصاحف")),
                              DataCell(droplist(quranCheck, " ")),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("متابعة الطلاب بالصلاة")),
                              DataCell(Checkbox(
                                visualDensity: VisualDensity.standard,
                                onChanged: (val) {
                                  setState(() {
                                    checks = !checks;
                                  });
                                },
                                value: checks,
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(" ملحوظات المدرس")),
                              DataCell(TextField(
                                decoration:
                                    InputDecoration(hintText: "..........."),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("نشاطات خلال الشهر")),
                              DataCell(TextField(
                                decoration:
                                    InputDecoration(hintText: "..........."),
                              )),
                            ]),
                          ]),
                    ),
                    ReportBottom(),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: nav_bottom());
  }
}
