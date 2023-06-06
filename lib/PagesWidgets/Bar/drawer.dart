import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/Teacher_page/Student/student_informatin.dart';
import 'package:test_ro_run/pages/sign_in.dart';
import 'package:test_ro_run/pages/teacherPage.dart';

import '../../Chat/screens/home_screen.dart';
import '../../showImage.dart';
import '../../User/Data.dart';
import '../../pages/Student_table.dart';
import '../../pages/posts.dart';
import '../../pages/signup.dart';
import '../../pages/stdPage.dart';
import '../../tables/schedule.dart';
import '../Teacher_page/Exams/Date.dart';
import '../Teacher_page/Exams/full_info.dart';
import '../Teacher_page/PersonalInfo/personal_information.dart';
import '../Teacher_page/report/lecture/Lecture.dart';
import '../student_page/PersonalStudent.dart';
import '../student_page/exam.dart';
import '../student_page/schedule/schedule.dart';

var Studentlist = [
  {'page': 'الصفحة الرئيسية', 'icon': Icon(Icons.home), 'go': student_page()},
  {
    'page': 'الامتحانات',
    'icon': Icon(Icons.pending_actions_outlined),
    'go': examstu()
  },
  {'page': 'العلامات', 'icon': Icon(Icons.date_range), 'go': Table_student1()},
  {
    'page': 'جدول الحفظ',
    'icon': Icon(Icons.table_chart_outlined),
    'go': schedule()
  },
  {'page': 'المنشورات', 'icon': Icon(Icons.post_add), 'go': posts()},
  {
    'page': 'البيانات الشخصية',
    'icon': Icon(Icons.insert_drive_file_rounded),
    'go': Personal_student(null)
  },
  {
    'page': 'التواصل مع المدرس',
    'icon': Icon(Icons.chat),
    'go': HomeScreen(Data.user)
  },
  {'page': 'تسجيل الخروج ', 'icon': Icon(Icons.exit_to_app), 'go': Signin()}
];

var teacherlist = [
  {'page': 'الصفحة الرئيسية', 'icon': Icon(Icons.home), 'go': teacher_page()},
  {'page': 'التقرير الشهري', 'icon': Icon(Icons.date_range), 'go': lecture()},
  {
    'page': 'جداول الحفظ',
    'icon': Icon(Icons.table_chart_outlined),
    'go': scheduleteacher()
  },
  {'page': 'المنشورات', 'icon': Icon(Icons.post_add), 'go': posts()},
  {
    'page': 'الطلاب',
    'icon': Icon(Icons.people),
    'go': student_Data(null, false)
  },
  {
    'page': 'التواصل مع الأهل',
    'icon': Icon(Icons.chat),
    'go': HomeScreen(Data.user)
  },
  {
    'page': 'الامتحانات',
    'icon': Icon(Icons.import_contacts_sharp),
    'go': ful_info()
  },
  {
    'page': 'البيانات الشخصية',
    'icon': Icon(Icons.insert_drive_file_rounded),
    'go': Personal_info()
  },
  {
    'page': 'إضافة طالب',
    'icon': Icon(Icons.people_alt_rounded),
    'go': Signup(false)
  },
  {
    'page': 'حذف طالب',
    'icon': Icon(Icons.remove_circle_rounded),
    'go': student_Data(null, true)
  },
  {'page': 'تسجيل الخروج ', 'icon': Icon(Icons.exit_to_app), 'go': Signin()}
];

class drawer extends StatefulWidget {
  double drawer_width;
  bool student;
  bool mainPage;

  drawer({Key myKey, this.student, this.drawer_width, this.mainPage})
      : super(key: myKey);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    var drawerlist = widget.student ? Studentlist : teacherlist;
    return Drawer(
        width: widget.drawer_width,
        child: Stack(
          children: [
            UserAccountsDrawerHeader(
              onDetailsPressed: () {},
              currentAccountPicture: ClipOval(
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(Data.user.email)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return InkWell(
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(snapshot.data['image']),
                          backgroundColor: Colors.transparent,
                        ),
                        onTap: () {
                          return Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return showImage(snapshot.data['image'], true);
                          }));
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              accountName: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(Data.user.email)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data['name']);
                  } else {
                    return Text("");
                  }
                },
              ),
              //   accountEmail: Text(widget.email)
            ),
            Container(
              margin: EdgeInsets.only(top: 189),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: drawerlist.length,
                  itemBuilder: (BuildContext context, i) {
                    return new ListTile(
                      title: new Text(
                        "${drawerlist[i]['page']}",
                      ),
                      trailing: drawerlist[i]['icon'],
                      onTap: () async {
                        Navigator.pop(context);
                        Date.date = null;
                        if (i == drawerlist.length - 1) {
                          await FirebaseAuth.instance.signOut();
                          Data.user = null;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    drawerlist[i]['go']),
                            (route) =>
                                false, // Remove all previous routes from the stack
                          );
                        } else {
                          widget.mainPage == null || i == 0
                              ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          drawerlist[i]['go']))
                              : Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                  return drawerlist[i]['go'];
                                }));
                        }
                      },
                    );
                  }),
            ),
          ],
        ));
  }
}
