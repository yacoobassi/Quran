import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/pages/posts.dart';
import '../User/Data.dart';
import '../PagesWidgets/Bar/appBar.dart';
import '../PagesWidgets/Bar/drawer.dart';
import '../PagesWidgets/Bar/notification.dart';
import '../PagesWidgets/student_page/profile_container.dart';
import '../PagesWidgets/student_page/grid.dart';

int messagesNum = 5, selected = 2;
double opacity = 1;
bool visible, infinity;

class teacher_page extends StatefulWidget {
  @override
  State<teacher_page> createState() => _teacher_pageState();
}

class _teacher_pageState extends State<teacher_page> {
  GlobalKey<ScaffoldState> globalkey = new GlobalKey<ScaffoldState>();
  show(String text) {
    globalkey.currentState.openEndDrawer();
    likeORcomment = text;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    visible = false;
    notificationInit();
    getToken();
  }

  notificationInit() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user granted provisional permission");
    } else {
      print("declind");
    }
  }

  getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      saveToken(token);
    });
  }

  saveToken(String token) async {
    var collection = await FirebaseFirestore.instance.collection('users');

    await collection.doc(Data.user.email).update({'token': token});
  }

  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    double drawer_width = screen < 600 ? double.infinity : 300;
    double width = screen < 500 ? screen - 100 : 500;

    infinity = screen < 600;
    return Scaffold(
      key: globalkey,
      drawer: drawer(
        student: false,
        drawer_width: drawer_width,
        mainPage: true,
      ),
      endDrawer: notification(
        width: screen,
        text: likeORcomment,
      ),
      body: Stack(alignment: Alignment.topCenter, children: [
        //    grid(width: width),
        Container(
            height: 200,
            child: appbar(
              title: "",
              show: show,
              width: true,
              opacity: 1,
            )),
        profile_container(
          width: width,
        ),

        grid(width: width, teacher: true),
      ]),
    );
  }
}
