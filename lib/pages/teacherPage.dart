import 'package:Quran/pages/posts.dart';
import 'package:Quran/widgets/Bar/profileBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/Bar/drawer.dart';
import '../widgets/Bar/appBar.dart';
import '../widgets/Bar/notification.dart';
import '../widgets/student_page/grid.dart';
import '../widgets/student_page/profile_container.dart';

int messagesNum = 5, selected = 2;
double opacity = 1;
bool visible, infinity;

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
    return Scaffold(
      drawer: drawer(
        name: "yacoob assi",
        email: "yacoobassi9@gmail.com",
        image: "images/face.jpg",
        student: false,
        drawer_width: drawer_width,
      ),
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
