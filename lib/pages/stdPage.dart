import 'package:Quran/pages/posts.dart';
import 'package:Quran/widgets/student_page/grid.dart';
import 'package:Quran/widgets/student_page/profile_container.dart';
import '../widgets/Bar/appBar.dart';
import 'package:flutter/material.dart';
import '../widgets/Bar/notification.dart';

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
  }
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
    double width = screen < 500 ? screen - 100 : 500;

    infinity = screen < 600;
    String name = "محمود مسعود";
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
