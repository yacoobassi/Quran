import 'dart:convert';

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

class grade extends StatefulWidget {
  grade();

  @override
  State<grade> createState() => _gradeState();
}

class _gradeState extends State<grade> {
  final request = Requst();
  AsyncSnapshot<dynamic> marksData;
  List dates = [];
  DateTime count;
  @override
  void initState() {
    super.initState();
    count = DateTime.now();
    getDates();
  }

  Future<void> getDates() async {
    final response = await request.postRequest(getMarksDate, {
      "instituteNum": Data.user.institute.toString(),
      "reginmentNum": Data.user.regiment.toString()
    });
    setState(() {
      marksData = AsyncSnapshot.withData(ConnectionState.done, response);
      if (marksData.hasData) {
        //  Date.date = marksData.data['data'][0]['date'];
        for (int i = 0; i < marksData.data['data'].length; i++) {
          dates.add(marksData.data['data'][i]['date']);
        }
      }
    });
  }

  Future<void> getData() async {
    final response = await request.postRequest(linkgetMarks, {
      "instituteNum": Data.user.institute.toString(),
      "reginmentNum": Data.user.regiment.toString(),
      "date": Date.date
    });

    return response == null ? "" : response;
  }

  @override
  Widget build(BuildContext context) {
    final columnTitle = [
      {"title": "الترتيب", "value": "order"},
      {"title": "الطالب", "value": "name"},
      {"title": "علامة الامتحان", "value": "mark"},
      {"title": "التقدير", "value": "estimate"}
    ];

    bool init = true;

    final cels = [
      Container(
        padding: EdgeInsets.all(8),
        child: TextField(
          enabled: false,
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        child: TextField(
          enabled: false,
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        child: TextField(
          enabled: false,
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        child: TextField(
          enabled: false,
        ),
      )
    ];
    const rowexa = 30;
    const numcol = 4;
    const numcel = 4;
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: drawer(student: false, drawer_width: drawer().drawer_width),
        appBar: AppBar(
          title: const Text(
            "الامتحانات ",
          ),
        ),
        bottomNavigationBar: bottom_Nav_exam(),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.data == "")
              return Center(child: Text("لا يوجد امتحانات"));
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [title("العلامات", "", "", "", 40)]),
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
                      SizedBox(
                        height: 10,
                      ),
                      tableExam(columnTitle, rowexa, numcol, numcel, snapshot,
                          false, null),
                    ],
                  ),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
