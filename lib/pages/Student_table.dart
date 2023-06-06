import 'package:flutter/material.dart';
import '../Links.dart';
import '../PagesWidgets/Bar/appBar.dart';
import '../PagesWidgets/Bar/drawer.dart';
import '../PagesWidgets/Bar/notification.dart';
import '../PagesWidgets/Teacher_page/report/table/date.dart';
import '../User/Data.dart';
import '../request.dart';
import 'posts.dart';
import 'package:test_ro_run/PagesWidgets/Teacher_page/Exams/table.dart';

final columnTitle = [
  {"title": "اليوم", "value": "day"},
  {"title": "التاريخ", "value": "date"},
  {"title": "موضع الحفظ", "value": "study"},
  {"title": "العلامة", "value": "studyMark"},
  {"title": "موضع المراجعة", "value": "review"},
  {"title": "العلامة", "value": "reviewMark"},
  {"title": "الحضور", "value": "exist"},
];

class data {
  String day, date, study, mark1, repeat, mark2, exist, view;

  data(day, date, study, mark1, repeat, mark2, exist, view) {
    this.day = day;
    this.date = date;
    this.study = study;
    this.mark1 = mark1;
    this.repeat = repeat;
    this.mark2 = mark2;
    this.exist = exist;
    this.view = view;
  }
}

int rowexa = 30;
int numcol = 7;
int numcel = 7;
bool visible;

class Table_student1 extends StatefulWidget {
  @override
  State<Table_student1> createState() => _Table_student1State();
}

class _Table_student1State extends State<Table_student1> {
  GlobalKey<ScaffoldState> globalkey = new GlobalKey<ScaffoldState>();
  show(String text) {
    globalkey.currentState.openEndDrawer();
    likeORcomment = text;
    setState(() {});
  }

  final request = Requst();

  Future<dynamic> getMark() async {
    final response = await request.postRequest(getStudentMarks, {
      "instituteNum": "1",
      "reginmentNum": "19",
      "date": "$thisYear-$thisMonth-1",
      "num": Data.user.email.replaceAll("@gmail.com", "")
    });
    return response;
  }

  DateTime now;
  int thisDay; // get the current day
  int thisMonth; // get the current month
  int thisYear;
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

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    thisDay = now.day; // get the current day
    thisMonth = now.month; // get the current month
    thisYear = now.year; //
  }

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;
    double drawer_width = screen < 600 ? double.infinity : 300;
    bool infinity;
    double _zoomLevel = 1.0;

    if (screen < 600)
      infinity = true;
    else
      infinity = false;
    return Scaffold(
        drawer: drawer(student: true, drawer_width: drawer().drawer_width),
        key: globalkey,
        appBar: appbar(
          title: "العلامات",
          show: show,
          width: false,
          opacity: 1,
        ),
        endDrawer: notification(
          width: screen,
          text: likeORcomment,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
            future: getMark(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    YearMonthDropdown(
                      onChanged: (year, month) {
                        thisMonth = month;
                        thisYear = year;
                        setState(() {
                          thisMonth = month;
                          thisYear = year;
                        });
                      },
                    ),
                    InteractiveViewer(
                      boundaryMargin: EdgeInsets.all(double.infinity),
                      minScale: 0.5,
                      maxScale: 4.0,
                      scaleEnabled: true,
                      panEnabled: true,
                      onInteractionUpdate: (details) {
                        setState(() {
                          _zoomLevel = details.scale;
                        });
                      },
                      child: Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(top: 15),
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                snapshot.data['data'].length > 0
                                    ? tableExam(columnTitle, rowexa, numcol,
                                        numcel, snapshot, false, null)
                                    : Center(child: Text("  لا يوجد علامات"))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
