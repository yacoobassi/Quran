import 'package:Quran/pages/posts.dart';
import 'package:Quran/widgets/Bar/profileBar.dart';
import '../widgets/Bar/appBar.dart';

import 'package:flutter/material.dart';

import '../widgets/Bar/notification.dart';
import '../widgets/student_page/profile_body.dart';

int messagesNum = 5, selected = 2;
double opacity = 1;
bool visible, infinity;
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
  {
    'page': 'تسجيل الخروج ',
    'icon': Icon(Icons.exit_to_app),
  },
];

class student_page extends StatefulWidget {
  @override
  State<student_page> createState() => _student_page();
}

class _student_page extends State<student_page> {
  @override
  show() {
    visible = !visible;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = false;
  }

  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    double drawer_width = screen < 600 ? double.infinity : 300;
    infinity = screen < 600 ? true : false;
    return Scaffold(
        drawer: Drawer(
            width: drawer_width,
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
                        onTap: () {
                          if (i == 4)
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return posts();
                            }));
                        },
                      );
                    }),
              ],
            )),
        appBar: appbar(title: "صفحة الطالب", show: show),
        body: Stack(alignment: Alignment.topLeft, children: [
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              color: Colors.black12,
              child: Column(children: [
                profileBar(
                  text: "محمد مسعود",
                  image: "images/face.jpg",
                ),
                Container(width: 700, child: profile_body()),
              ])),
          notification(
            show: visible,
            infinty: infinity,
          )
        ])
      

        );
  }
}
