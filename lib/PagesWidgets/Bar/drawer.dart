import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/Teacher_page/Student/student_informatin.dart';
import 'package:test_ro_run/pages/teacherPage.dart';

import '../../Chat/Chat.dart';
import '../../pages/Student_table.dart';
import '../../pages/posts.dart';
import '../../pages/signup.dart';
import '../../pages/stdPage.dart';
import '../../sharedPref.dart';
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
    'page': 'البوم الصور',
    'icon': Icon(Icons.import_contacts_sharp),
    'go': posts()
  },
  {
    'page': 'البيانات الشخصية',
    'icon': Icon(Icons.insert_drive_file_rounded),
    'go': Personal_student()
  },
  {'page': 'التواصل مع المدرس', 'icon': Icon(Icons.chat), 'go': Chat()},
  {'page': 'صفحة المدرس', 'icon': Icon(Icons.person), 'go': teacher_page()},
  {'page': 'تسجيل الخروج ', 'icon': Icon(Icons.exit_to_app), 'go': posts()}
];

var teacherlist = [
  {'page': 'الصفحة الرئيسية', 'icon': Icon(Icons.home), 'go': teacher_page()},
  {'page': 'التقرير الشهري', 'icon': Icon(Icons.date_range), 'go': lecture()},
  {
    'page': 'جداول الحفظ',
    'icon': Icon(Icons.table_chart_outlined),
    'go': schedule()
  },
  {'page': 'المنشورات', 'icon': Icon(Icons.post_add), 'go': posts()},
  {'page': 'الطلاب', 'icon': Icon(Icons.people), 'go': student_Data()},
  {'page': 'التواصل مع الأهل', 'icon': Icon(Icons.chat), 'go': Chat()},
  {
    'page': 'البوم الصور',
    'icon': Icon(Icons.picture_in_picture),
    'go': posts()
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
    'page': 'صفحة الطالب',
    'icon': Icon(Icons.picture_in_picture),
    'go': student_page()
  },
  {
    'page': 'بيانات الطلاب',
    'icon': Icon(Icons.table_view_sharp),
    'go': student_Data()
  },
  {
    'page': 'إضافة الطلاب',
    'icon': Icon(Icons.people_alt_rounded),
    'go': Signup()
  },
  {
    'page': 'إضافة أستاذ مساعد',
    'icon': Icon(Icons.person_add_alt_1),
    'go': Signup()
  },
];

class drawer extends StatefulWidget {
  double drawer_width;
  bool student;

  drawer({Key myKey, this.student, this.drawer_width}) : super(key: myKey);

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
                  future: Pref.getProfileImage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(snapshot.data),
                        backgroundColor: Colors.transparent,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              accountName: FutureBuilder(
                future: Pref.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data);
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
                        if (i == drawerlist.length - 1) {
                          // await GoogleSignIn().signOut();
                          await FirebaseAuth.instance.signOut();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  drawerlist[i]['go'],
                            ),
                          );
                        }
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return drawerlist[i]['go'];
                        }));
                      },
                    );
                  }),
            ),
          ],
        ));
  }
}
