import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Links.dart';
import '../../../User/Data.dart';
import '../../../request.dart';
import '../../../tables/tableTitle.dart';
import '../../Bar/drawer.dart';
import '../report/lecture/dropdown.dart';
import 'Date.dart';
import 'examNavBottom.dart';

class ful_info extends StatefulWidget {
  ful_info();

  @override
  State<ful_info> createState() => _ful_infoState();
}

class _ful_infoState extends State<ful_info> {
  Requst request = new Requst();

  String reginment = "",
      institute = "",
      day = "",
      date = "",
      mark = "",
      tajoeedMark = "",
      sum = "",
      avarege = "",
      estimte = "",
      parts = "",
      students = "",
      commitee = "",
      prizes = "";

  AsyncSnapshot<dynamic> marksData;

  List dates = [];

  DateTime start;
  @override
  void initState() {
    super.initState();

    getDates();
    start = DateTime.now();
  }

  Future<void> getDates() async {
    final response = await request.postRequest(getMarksDate, {
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment,
    });

    setState(() {
      marksData = AsyncSnapshot.withData(ConnectionState.done, response);
      if (marksData.hasData && marksData.data['data'].length > 0) {
        if (Date.date == null) Date.date = marksData.data['data'][0]['date'];
        for (int i = 0; i < marksData.data['data'].length; i++) {
          dates.add(marksData.data['data'][i]['date']);
        }
      }
    });

    return response;
  }

  getExam() async {
    var response = await request.postRequest(linkgetExam, {
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment,
      "date": Date.date
    });
    return Date.date == null ? "" : response;
  }

  initial(AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.data['data'].length == 0) return;
    reginment = snapshot.data['data'][0]['instituteNum'].toString();
    institute = snapshot.data['data'][0]['regimentNum'].toString();
    day = snapshot.data['data'][0]['day'];
    date = snapshot.data['data'][0]['date'].toString();
    mark = snapshot.data['data'][0]['passMark'];
    tajoeedMark = snapshot.data['data'][0]['tajoeedMark'];
    sum = snapshot.data['data'][0]['sum'];
    avarege = snapshot.data['data'][0]['avarege'];
    estimte = snapshot.data['data'][0]['estimate'];
    parts = snapshot.data['data'][0]['parts'];
    students = snapshot.data['data'][0]['students'].toString();
    commitee = snapshot.data['data'][0]['commitee'];
    prizes = snapshot.data['data'][0]['prizes'];
  }

  @override
  Widget build(BuildContext context) {
    int numrowexa1 = 13;
    int numcol1 = 2;
    int numcel1 = 2;

    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: drawer(student: false, drawer_width: drawer().drawer_width),
        appBar: AppBar(
          title: Text(
            "الامتحانات",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        bottomNavigationBar: bottom_Nav_exam(),
        body: FutureBuilder(
            future: getExam(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == "")
                  return Center(child: Text("لا يوجد امتحانات"));
                initial(snapshot);

                List<String> co = ["الامتحان", "المؤمنون"];
                List title = [
                  tableTitle().titles('الفوج'),
                  tableTitle().titles('المركز'),
                  tableTitle().titles(
                    'اليوم',
                  ),
                  tableTitle().titles('التاريخ'),
                  tableTitle().titles('علامة النجاح'),
                  tableTitle().titles('علامة التجويد'),
                  tableTitle().titles('مجموع العلامات'),
                  tableTitle().titles('معدل المركز'),
                  tableTitle().titles('التقدير'),
                  tableTitle().titles('الأجزاء الممتحن بها'),
                  tableTitle().titles('عدد الطلاب بعد الامتحان'),
                  tableTitle().titles('لجنة الامتحان'),
                  tableTitle().titles('الجوائز'),
                  tableTitle().titles('ملاحظات'),
                ];
                List contain = [
                  Text(reginment,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(institute,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(day,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(date,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(mark,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(tajoeedMark,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(sum,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(avarege,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(estimte,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 120,
                      ),
                      child: Text(
                        parts,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Text(students,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 120,
                      ),
                      child: Text(commitee,
                          maxLines: 5,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 120,
                      ),
                      child: Text(prizes,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Text(
                    "  ",
                    overflow: TextOverflow.fade,
                  )
                ];
                var celles = [];
                for (int i = 0; i < title.length; i++) {
                  celles.add(title[i]);
                  celles.add(contain[i]);
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("تاريخ الامتحان  "),
                              droplist(dates, Date.date, (val) {
                                setState(() {
                                  Date.date = val;
                                });
                              }),
                            ]),
                        Card(
                          elevation: 8,
                          child: DataTable(
                            dataRowHeight: 70,
                            dataTextStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: 'Cairo',
                            ),
                            headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.green.withOpacity(0.2),
                            ),
                            columns: tableTitle().col(numcol1, co),
                            rows: tableTitle()
                                .rowexam(numrowexa1, numcel1, celles),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else
                return Center(child: CircularProgressIndicator());
            })));
  }
}
