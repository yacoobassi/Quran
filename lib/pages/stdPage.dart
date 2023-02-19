import 'package:Quran/pages/posts.dart';
import 'package:Quran/widgets/student_page/grid.dart';
import 'package:Quran/widgets/student_page/profile_container.dart';
import '../widgets/Bar/drawer.dart';
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
      drawer: drawer(
          student: true,
          email: "Yacoobassi8@gmai.com",
          name: "Yacoob assi",
          image: "images/face.jpg",
          drawer_width: drawer_width),
      endDrawer: notification(),
      body: Stack(alignment: Alignment.topCenter, children: [
        grid(width: width),
        Container(
            height: 200, child: appbar(title: "", show: show, width: true)),
        profile_container(
          name: "محمد مسعود",
          width: width,
        )
      ]),
    );
  }
}
