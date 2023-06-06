import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/Teacher_page/Exams/table.dart';

import '../../../Links.dart';
import '../../../User/Data.dart';
import '../../../pages/posts.dart';
import '../../../request.dart';
import '../../../title.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';
import '../report/lecture/dropdown.dart';
import 'Date.dart';
import 'examNavBottom.dart';

List exam = [" ", "جزء عم", "عم وتبارك ", "عم وتبارك والمجادلة"];
List columnTitle = [
  {"title": "الترتيب", "value": "order"},
  {"title": "الطالب", "value": "name"},
  {"title": "علامة الامتحان", "value": "mark"},
  {"title": "التقدير", "value": "estimate"},
  {"title": "علامة الامتحان السابق", "value": "lastExam"},
  {"title": "خصم التجويد", "value": "tajoeedMinus"},
  {"title": "ملاحظات", "value": "notes"},
];

int rowexa = 30;
int numcol = 7;
int numcel = 7;
final request = Requst();

class fullTable extends StatefulWidget {
  fullTable();

  @override
  State<fullTable> createState() => _fullTableState();
}

class _fullTableState extends State<fullTable> {
  DateTime count;

  @override
  void initState() {
    super.initState();
    getDates();
    count = DateTime.now();
  }

  AsyncSnapshot<dynamic> marksData;
  List dates = [];
  Future<dynamic> getMark() async {
    final response = await request.postRequest(linkgetMarks, {
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment,
      "date": Date.date
    });
    return response == null ? "" : response;
  }

  Future<void> getDates() async {
    final response = await request.postRequest(getMarksDate, {
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment.toString()
    });
    setState(() {
      marksData = AsyncSnapshot.withData(ConnectionState.done, response);
      if (marksData.hasData) {
        // Date.date = marksData.data['data'][0]['date'];
        for (int i = 0; i < marksData.data['data'].length; i++) {
          dates.add(marksData.data['data'][i]['date']);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: drawer(student: false, drawer_width: drawer().drawer_width),
        appBar: AppBar(
          title: Text(
            "الامتحانات ",
          ),
        ),
        bottomNavigationBar: bottom_Nav_exam(),
        body: FutureBuilder(
          future: getMark(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == "")
                return Center(child: Text("لا يوجد امتحانات"));
              return Center(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                          child: Container(
                        padding: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height - 145,
                        child: Column(
                          children: [
                            title("أسماء المتقدمين للامتحان حسب النتيجة", "",
                                "", "", 30),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("تاريخ الامتحان  "),
                                  droplist(dates, Date.date, (val) {
                                    setState(() {
                                      Date.date = val;
                                    });
                                    // call fetchMarks() with the new selected date
                                  }),
                                ]),
                            tableExam(columnTitle, rowexa, numcol, numcel,
                                snapshot, false, null)
                          ],
                        ),
                      ))));
            } else
              return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
