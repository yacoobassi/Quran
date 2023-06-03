import 'package:flutter/material.dart';

import '../../../Chat/screens/search_screen.dart';
import '../../../Links.dart';
import '../../../pages/posts.dart';
import '../../../request.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';
import '../Exams/table.dart';

class student_Data extends StatefulWidget {
  student_Data(this.Student);
  String Student;

  @override
  State<student_Data> createState() => _student_DataState();
}

class _student_DataState extends State<student_Data> {
  List columnTitle1 = [
    {"title": "رقم الطالب", "value": "co"},
    {"title": "رقم تسجيل الطالب", "value": "num"},
    {"title": "الاسم الرباعي", "value": "name"},
    {"title": "الصف", "value": "grade"},
    {"title": "المستوى الدراسي", "value": "grade"},
    {"title": "تاريخ الميلاد", "value": "birth"},
    {"title": "رقم جوال الأب", "value": "fatherPhone"},
    {"title": "رقم جوال الأم", "value": "motherPhone"},
    {"title": "عنوان السكن", "value": "house"},
    {"title": "المعدل التراكمي", "value": "mark"},
  ];
  Requst request = new Requst();

  getInfo() async {
    var response = await request
        .postRequest(linkGetAllStudents, {"institute": "1", "regiment": "19"});

    return response;
  }

  geonetInfo() async {
    var response = await request.postRequest(linkGETStData,
        {"num": widget.Student, "instituteNum": "1", "regimentNum": "19"});
    return response;
  }

  int rowexa1 = 34;
  int numcol1 = 10;
  int numcel1 = 10;
  List cels = [];

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: drawer(student: false, drawer_width: drawer().drawer_width),
      appBar: AppBar(
        title: Text(
          "الطلاب",
        ),
      ),
      body: FutureBuilder(
        future: widget.Student == null ? getInfo() : geonetInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    child: tableExam(
                        columnTitle1, rowexa1, numcol1, numcel1, snapshot),
                  ),
                ),
              ],
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SearchScreen(false)));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
