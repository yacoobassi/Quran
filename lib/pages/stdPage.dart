import 'package:Quran/appBar.dart';
import 'package:Quran/pages/posts.dart';
import 'package:Quran/profileBar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

int messagesNum = 5, selected = 2;
double opacity = 1;
var drawerlist = [
  {
    'page': 'الصفحة الرئيسية',
    'icon': Icon(Icons.home),
  },
  {'page': 'الامتحانات', 'icon': Icon(Icons.pending_actions_outlined)},
  {
    'page': 'العلامات',
    'icon': Icon(Icons.date_range),
  },
  {
    'page': 'جدول الحفظ',
    'icon': Icon(Icons.table_chart_outlined),
  },
  {
    'page': 'المنشورات',
    'icon': Icon(Icons.post_add),
  },
  {
    'page': 'البوم الصور',
    'icon': Icon(Icons.picture_in_picture),
  },
];

class student_page extends StatefulWidget {
  @override
  State<student_page> createState() => _student_page();
}

class _student_page extends State<student_page> {
  @override
  Widget build(BuildContext context) {
    var notification_num = 1;
    var messege_num = 1;
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
              onDetailsPressed: () {},
              currentAccountPicture: ClipOval(
                child: Image.asset("images/face.jpg"),
              ),
              accountName: Text("Mohammad"),
              accountEmail: Text("Mohammad@hotmail.com")),
          ListView.builder(
              shrinkWrap: true,
              itemCount: drawerlist.length,
              itemBuilder: (BuildContext context, i) {
                return new ListTile(
                  title: new Text(
                    "${drawerlist[i]['page']}",
                  ),
                  trailing: drawerlist[i]['icon'],
                  onTap: () {},
                );
              }),
        ],
      )),
      appBar: appBar("صفحة الطالب"),
      body: Container(
        child: Column(children: [
          profileBar(text: "name1", image: "images/face.jpg"),
          profile_body()
        ]),
      ),
    );
  }
}

class profile_body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "الاسم : يعقوب عادل عاصي",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "المركز : 16",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "5 : عدد الاجزاء التي اتمها الطالب",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            "الجزء الحالي : جزء عم",
            style: TextStyle(fontSize: 15),
          ),
          Text(
            "علامة الامتحان السابق : 90",
            style: TextStyle(fontSize: 15),
          ),
          Text(
            "المعدل التركمي : 90",
            style: TextStyle(fontSize: 15),
          ),
        ])
      ],
    );
  }
}
