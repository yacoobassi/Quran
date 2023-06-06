import 'package:flutter/material.dart';

import '../../Links.dart';
import '../../User/Data.dart';
import '../../pages/posts.dart';
import '../../request.dart';
import '../Bar/drawer.dart';
import '../Bar/notification.dart';
import '../Teacher_page/Exams/table.dart';

class examstu extends StatelessWidget {
  examstu();
  Requst request = new Requst();
  getExam() async {
    var response = await request.postRequest(getAllStuExams, {
      "num": Data.user.email.replaceAll("@gmail.com", ""),
    });

    return response;
  }

  int rowexa = 15, numcol = 3, numcel = 3;
  final collist = [
    {"title": "الامتحان", "value": "parts"},
    {"title": "العلامة", "value": "mark"},
    {"title": "التقدير", "value": "estimate"},
  ];
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("الامتحانات"),
        ),
        drawer: drawer(student: true, drawer_width: drawer().drawer_width),
        body: FutureBuilder(
          future: getExam(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "علامة اخر امتحان",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data['count'] > 0
                                        ? "%${snapshot.data['data'][0]['mark']}"
                                        : "لا يوجد علامة",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "المعدل التراكمي",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "%${(double.parse(snapshot.data['avg_mark'])).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "علامات الامتحانات",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width *
                            0.9, // set the width to 90% of the screen width
                        child: tableExam(collist, rowexa, numcol, numcel,
                            snapshot, false, null),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
