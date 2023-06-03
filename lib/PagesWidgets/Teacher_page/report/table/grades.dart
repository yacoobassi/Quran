import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../Links.dart';
import '../../../../pages/posts.dart';
import '../../../../request.dart';
import '../../../Bar/drawer.dart';
import '../../../Bar/notification.dart';
import '../lecture/dropdown.dart';
import '../lecture/navigator_buttom.dart';
import 'bottom_table.dart';
import 'date.dart';
import 'dateTable.dart';
import 'gettable.dart';

class grades extends StatefulWidget {
  @override
  State<grades> createState() => _gradesState();
}

DateTime date = DateTime.now();
bool check = false;
List gruob = [
  "1",
  "2",
  "3",
  "4",
  "5",
];

List month = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
];
DateTime now;
int thisDay; // get the current day
int thisMonth; // get the current month
int thisYear; // get the current year// set the default selected year

class _gradesState extends State<grades> {
  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    thisDay = now.day; // get the current day
    thisMonth = now.month; // get the current month
    thisYear = now.year; //
  }

  Requst request = new Requst();
  String groupValue = "1";
  bool init = false;

  changeGroup(String group) {
    setState(() {
      init = false;
      groupValue = group;
    });
  }

  getStudentsNumber() async {
    var response = await request.postRequest(linkClassStudents, {
      "instituteNum": "1",
      "reginmentNum": "19",
      "group": groupValue,
      "date": "$thisYear-$thisMonth-$thisDay"
    });
    init = true;
    return response;
  }

  updateClass(AsyncSnapshot<dynamic> snapshot) async {
    String jsonString = jsonEncode(snapshot.data);

// decode the JSON string to a Map
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

// update the keys and values in the Map as required

// convert the updated Map to a JSON string
    String updatedJsonString = json.encode(jsonMap);
    await request.postRequest(linkupdateClass, {
      "instituteNum": "1",
      "reginmentNum": "19",
      "group": groupValue,
      "date": "${thisYear}-${thisMonth}-${date.day}",
      "snapshot": updatedJsonString
    });
    setState(() {
      init = false;
    });
  }

  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;

    DateTime selectedDate = DateTime.now(); // set the default selected date
    AsyncSnapshot<dynamic> save;
// in your build method

    return Scaffold(
        drawer: drawer(student: false, drawer_width: drawer().drawer_width),
        endDrawer: notification(
          width: screen,
          text: likeORcomment,
        ),
        appBar: AppBar(
          title: Text(
            "التقرير الشهري",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: nav_bottom(null, false),
        body: SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          "رقم المجموعة",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 10),
                        droplist(gruob, groupValue, changeGroup),
                        SizedBox(
                          width: 25,
                        ),
                        YearMonthDropdown(
                          onChanged: (year, month) {
                            thisMonth = month;
                            thisYear = year;
                            setState(() {
                              thisMonth = month;
                              thisYear = year;
                              init = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Expanded(
                    child: FutureBuilder(
                      future: !init ? getStudentsNumber() : save,
                      builder: ((context, snapshot) {
                        save = snapshot;
                        if (snapshot.hasData) {
                          return Column(children: [
                            Container(
                              width: 830,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data['count'],
                                itemBuilder: (context, i) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data['data'][i]['name'],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 30),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              dateTable(snapshot),
                                              SizedBox(width: 20),
                                              gettable(snapshot, i),
                                              SizedBox(width: 20),
                                              bottomInfo(snapshot, i),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        updateClass(snapshot);
                                      },
                                      child: Text("حفظ البيانات")),
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                          ]);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
