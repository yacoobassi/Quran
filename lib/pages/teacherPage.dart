import 'package:Quran/widgets/Bar/profileBar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../widgets/Bar/appBar.dart';

int messagesNum = 5, selected = 2;
double opacity = 1;
bool visible = false;
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
   {
    'page': 'تسجيل الخروج ',
    'icon': Icon(Icons.exit_to_app),
  },
];

class teacher_page extends StatefulWidget {
  @override
  State<teacher_page> createState() => _teacher_pageState();
}

class _teacher_pageState extends State<teacher_page> {
  @override
  show() {
    visible = !visible;

    setState(() {});
  }

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
      appBar: appbar(title: "صفحة المدرس", show: show),
      body: Container(
          child: Column(
        children: [profileBar(text: "محمد مسعود", image: "images/face.jpg")],
      )),
    );
  }
}
