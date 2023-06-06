import 'package:flutter/material.dart';
import 'package:test_ro_run/request.dart';

import '../../../../Links.dart';
import '../../../../User/Data.dart';
import '../../../../pages/posts.dart';
import '../../../Bar/drawer.dart';
import '../../../Bar/notification.dart';
import '../Controller.dart';
import '../lecture/dropdown.dart';
import '../lecture/navigator_buttom.dart';
import 'Reportbottom.dart';

List days = [" ", "{أحد,ثلاثاء,خميس}", "{سبت,اثنين,أربعاء}"];
List quranCheck = [" ", "لم يحضروها ", "أحضروها"];
bool checks = false;
String selectedDays = "{أحد,ثلاثاء,خميس}";
String Quran = " ";

class report extends StatefulWidget {
  const report();

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  DateTime date = DateTime.now();
  Requst request = new Requst();

  String tajoeed, study, review;

  setAvg(String t, String s, String r) {
    tajoeed = t;
    study = s;
    review = r;
  }

  changeDays(String days) {
    selectedDays = days;
  }

  changeQuranCheck(String val) {
    Quran = val;
  }

  getStudentsNumber() async {
    var response = await request.postRequest(linkGetAllStudents, {
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment,
    });

    return response;
  }

  getInsName() async {
    var response = await request.postRequest(linkInsName, {
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment
    });

    return response;
  }

  getTeacherName() async {
    var response = await request.postRequest(linkTeacherName, {
      "instituteNum": Data.user.institute.toString(),
      "reginmentNum": Data.user.regiment.toString(),
    });

    return response;
  }

  newReport() async {
    // widget.Loading();

    //widget.Loading();
    int nextmonth = DateTime.now().month + 1 % 12;
    var response = await request.postRequest(linkNewReport, {
      "instituteNum": Data.user.institute,
      "regimentNum": Data.user.regiment,
      "reportDate":
          "${nextmonth == 0 ? nextmonth + 1 : nextmonth}/${DateTime.now().year}",
      "studenstNum": "30",
      "daysNum": Controller.daysNum.text,
      "studyDays": selectedDays,
      "startHour": Controller.startHour.text,
      "quranCheck": Quran,
      "studentsCheck": checks ? "1" : "0",
      "activity": Controller.activites.text,
      "rememberMark": study,
      "reviewMark": review,
      "tajoeed": tajoeed,
      "notes": Controller.notes.text,
    });

    if (response['status'] == "success") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("تمت حفظ البيانات")));

      Controller.startHour.text = "";
      Controller.notes.text = "";
      Controller.activites.text = "";
      Controller.daysNum.text = "";
    } else
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("لم يتم الحفظ")));
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: drawer(student: false, drawer_width: drawer().drawer_width),
        appBar: AppBar(
          title: Text(
            "التقرير الشهري",
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
                            DataColumn(label: Text("المركز")),
                            DataColumn(
                                label: FutureBuilder(
                                    future: getInsName(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                            snapshot.data['data'][0]['name']);
                                      } else
                                        return Text("");
                                    })),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text("الفوج")),
                              DataCell(Text(Data.user.regiment)),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("عدد الطلاب: رسميون")),
                              DataCell(FutureBuilder(
                                  future: getStudentsNumber(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                          snapshot.data['count'].toString());
                                    } else
                                      return Text("");
                                  })),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("الأستاذ")),
                              DataCell(FutureBuilder(
                                future: getTeacherName(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(snapshot.data['data'].length > 0
                                        ? snapshot.data['data'][0]['name']
                                        : "");
                                  } else {
                                    return Text("");
                                  }
                                },
                              )),
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
                              DataCell(Text("عدد أيام دوام الدورة الفعلي")),
                              DataCell(TextField(
                                controller: Controller.daysNum,
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(hintText: "..........."),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("أيام دوام الشهر القادم")),
                              DataCell(
                                  droplist(days, selectedDays, changeDays)),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("ساعة دوام الشهر القادم")),
                              DataCell(TextField(
                                controller: Controller.startHour,
                                decoration:
                                    InputDecoration(hintText: "..........."),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("تفقد المصاحف")),
                              DataCell(droplist(
                                  quranCheck, Quran, changeQuranCheck)),
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
                              DataCell(Text("ملحوظات المدرس")),
                              DataCell(TextField(
                                controller: Controller.notes,
                                decoration:
                                    InputDecoration(hintText: "..........."),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("نشاطات خلال الشهر")),
                              DataCell(TextField(
                                controller: Controller.activites,
                                decoration:
                                    InputDecoration(hintText: "..........."),
                              )),
                            ]),
                          ]),
                    ),
                    ReportBottom(setAvg),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: nav_bottom(newReport, true));
  }
}
