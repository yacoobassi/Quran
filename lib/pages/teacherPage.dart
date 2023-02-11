import 'package:Quran/appBar.dart';
import 'package:Quran/profileBar.dart';
import 'package:flutter/material.dart';

int messagesNum = 5, selected = 2;
double opacity = 1;
var drawerlist = [
  {
    'page': 'الصفحة الرئيسية',
    'icon': Icon(Icons.home),
  },
  {'page': 'التقرير الشهري', 'icon': Icon(Icons.date_range)},
  {
    'page': 'جداول الحفظ',
    'icon': Icon(Icons.table_chart_outlined),
  },
  {
    'page': 'المنشورات',
    'icon': Icon(Icons.post_add),
  },
  {
    'page': 'الطلاب',
    'icon': Icon(Icons.people),
  },
  {
    'page': 'التواصل مع الأهل',
    'icon': Icon(Icons.email_rounded),
  },
  {
    'page': 'البوم الصور',
    'icon': Icon(Icons.picture_in_picture),
  },
];

class teacher_page extends StatefulWidget {
  @override
  State<teacher_page> createState() => _teacher_pageState();
}

class _teacher_pageState extends State<teacher_page> {
  @override
  Widget build(BuildContext context) {
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
      appBar: appBar("صفحة المدرس"),
      body: Container(
          child: Column(
        children: [profileBar(text: "محمد مسعود", image: "images/face.jpg")],
      )),
    );
  }
}
