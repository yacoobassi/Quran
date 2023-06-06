import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Links.dart';
import '../../../../User/Data.dart';
import '../../../../request.dart';
import '../../../Bar/drawer.dart';
import '../Controller.dart';
import '../table/grades.dart';
import 'dropdown.dart';
import 'navigator_buttom.dart';

DateTime date = DateTime.now();
DateTime now = DateTime.now();
String selectedday = DateFormat('EEEE', 'ar').format(now);

var selectedPart = "عم";

final tabs = [grades(), lecture()];

String Titlerow;
List days = [
  "السبت",
  "الأحد",
  "الاثنين",
  "الثلاثاء",
  "الأربعاء",
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
  Requst request = new Requst();

  bool exist = false;
  changeDay(String day) {
    selectedday = day;
  }

  changePart(String part) {
    selectedPart = part;
  }

  updateClass() async {
    var response = await request.postRequest(updateClassData, {
      "day": selectedday,
      "date": "${date.year}/${date.month}/${date.day}",
      "classNum": Controller.classNum.text,
      "part": selectedPart,
      "study": Controller.studyPosition.text,
      "review": Controller.reviewPosition.text,
      "tajoeed": Controller.reviewPosition.text,
      "teacherExist": check ? "1" : "0",
      "end":
          "${timeend.hour % 12 == 0 ? timeend.hour % 12 : (timeend.hour % 12) + 1}:${timeend.minute}",
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment,
    });

    if (response['status'] == "success") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("تمت حفظ البيانات")));
    } else
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("لم يتم الحفظ")));
  }

  newClass() async {
    var response = await request.postRequest(linkNewClass, {
      "day": selectedday,
      "date": "${date.year}/${date.month}/${date.day}",
      "classNum": Controller.classNum.text,
      "part": selectedPart,
      "study": Controller.studyPosition.text,
      "review": Controller.reviewPosition.text,
      "tajoeed": Controller.tajoeedPosition.text,
      "teacherExist": check ? "1" : "0",
      "start":
          "${timest.hour % 12 == 0 ? timest.hour % 12 : (timest.hour % 12) + 1}:${timest.minute}",
      "end":
          "${timeend.hour % 12 == 0 ? timeend.hour % 12 : (timeend.hour % 12) + 1}:${timeend.minute}",
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment,
    });

    if (response['status'] == "success") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("تمت حفظ البيانات")));
    } else
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("لم يتم الحفظ")));

    return response;
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: drawer(student: false, drawer_width: drawer().drawer_width),
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
                        DataCell(droplist(days, selectedday, changeDay)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("التاريخ")),
                        DataCell(
                            Text("${date.year}/${date.month}/${date.day} ")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("رقم الحصة")),
                        DataCell(TextFormField(
                          controller: Controller.classNum,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("الجزء")),
                        DataCell(droplist(Part, selectedPart, changePart)),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("موضع الحفظ")),
                        DataCell(TextField(
                          controller: Controller.studyPosition,
                          decoration: InputDecoration(hintText: "..........."),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("موضع المراجعة")),
                        DataCell(TextField(
                          controller: Controller.reviewPosition,
                          decoration: InputDecoration(hintText: "..........."),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("مادة التجويد")),
                        DataCell(TextField(
                          controller: Controller.tajoeedPosition,
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
                                date = DateTime.now();
                                timest = date;
                              });
                              newClass();
                            },
                            child: Text(
                                "${timest.hour % 12 == 0 ? timest.hour % 12 : (timest.hour % 12) + 1}:${timest.minute}  إبدأ"))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("موعد نهاية الحصة")),
                        DataCell(ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (con) {
                                    return AlertDialog(
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              setState(() {
                                                date = DateTime.now();
                                                timeend = date;
                                                Controller.classNum.text = "";
                                                Controller.reviewPosition.text =
                                                    "";
                                                Controller.studyPosition.text =
                                                    "";
                                                Controller
                                                    .tajoeedPosition.text = "";
                                              });
                                              updateClass();
                                            },
                                            child: Text("تأكيد")),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("إلغاء")),
                                      ],
                                      title: Text(
                                        "تأكيد الانهاء",
                                        style: TextStyle(),
                                      ),
                                      content: Text(
                                        "هل أنت متأكد من انهاء الحصة",
                                        softWrap: true,
                                      ),
                                    );
                                  });
                              setState(() {
                                date = DateTime.now();

                                timeend = date;
                              });
                            },
                            child: Text(
                                "${timeend.hour % 12 == 0 ? timeend.hour % 12 : (timeend.hour % 12) + 1}:${timeend.minute}  انهي"))),
                      ]),
                    ]),
              ),
            ]),
          ),
        ),
        bottomNavigationBar: nav_bottom(null, false));
  }
}
