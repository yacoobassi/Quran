import 'package:flutter/material.dart';

import '../../../Chat/screens/search_screen.dart';
import '../../../Links.dart';
import '../../../User/Data.dart';
import '../../../pages/posts.dart';
import '../../../request.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';
import '../Exams/table.dart';

class student_Data extends StatefulWidget {
  student_Data(this.Student, this.delete);
  String Student;
  bool delete;

  @override
  State<student_Data> createState() => _student_DataState();
}

class _student_DataState extends State<student_Data> {
  List columnTitle1 = [
    {"title": "حذف الطالب"},
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
    var response = await request.postRequest(linkGetAllStudents, {
      "institute": Data.user.institute,
      "regiment": Data.user.regiment,
    });

    return response;
  }

  geonetInfo() async {
    var response = await request.postRequest(linkGETStData, {
      "num": widget.Student,
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment,
    });
    return response;
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int rowexa1 = 34;
    int numcol1 = widget.delete ? 11 : 10;
    int numcel1 = numcol1;
    List cels = [];

    return Scaffold(
      drawer: drawer(student: false, drawer_width: drawer().drawer_width),
      appBar: AppBar(
        title: Text(
          widget.delete ? "الحذف" : "الطلاب",
        ),
      ),
      body: FutureBuilder(
        future: widget.Student == null ? getInfo() : geonetInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data['count'] > 0
                ? ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                            child: tableExam(columnTitle1, rowexa1, numcol1,
                                numcel1, snapshot, widget.delete, refresh)),
                      ),
                    ],
                  )
                : Center(
                    child: Text("لا يوجد طلاب"),
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(false, widget.delete),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
