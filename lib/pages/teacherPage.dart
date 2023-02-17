import 'package:Quran/pages/posts.dart';
import 'package:Quran/widgets/Bar/profileBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/Bar/appBar.dart';
import '../widgets/Bar/notification.dart';
import '../widgets/student_page/grid.dart';
import '../widgets/student_page/profile_container.dart';

int messagesNum = 5, selected = 2;
double opacity = 1;
bool visible, infinity;
var drawerlist = [
  {'page': 'الصفحة الرئيسية', 'icon': Icon(Icons.home), 'go': posts()},
  {'page': 'التقرير الشهري', 'icon': Icon(Icons.date_range), 'go': posts()},
  {
    'page': 'جداول الحفظ',
    'icon': Icon(Icons.table_chart_outlined),
    'go': posts()
  },
  {'page': 'المنشورات', 'icon': Icon(Icons.post_add), 'go': posts()},
  {'page': 'الطلاب', 'icon': Icon(Icons.people), 'go': posts()},
  {
    'page': 'التواصل مع الأهل',
    'icon': Icon(Icons.email_rounded),
    'go': posts()
  },
  {
    'page': 'البوم الصور',
    'icon': Icon(Icons.picture_in_picture),
    'go': posts()
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = false;
  }

  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    double drawer_width = screen < 600 ? double.infinity : 300;
    double width = screen < 500 ? screen - 100 : 500;

    infinity = screen < 600;
    String name = "محمد مسعود";
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
                        Navigator.pop(context);

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return drawerlist[i]['go'];
                        }));
                      },
                    );
                  }),
            ],
          )),
      body: Stack(alignment: Alignment.topLeft, children: [
        Stack(alignment: Alignment.topCenter, children: [
          grid(width: width),
          Container(
              height: 200, child: appbar(title: "", show: show, width: true)),
          profile_container(
            name: "محمد مسعود",
            width: width,
          )
        ]),
        notification(
          show: visible,
          infinty: infinity,
          margin: true,
        ),
      ]),
    );
  }
}
