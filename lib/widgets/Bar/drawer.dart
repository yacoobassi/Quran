import 'package:Quran/pages/posts.dart';
import 'package:Quran/pages/stdPage.dart';
import 'package:Quran/widgets/Teacher_page/Exams/full_info.dart';
import 'package:Quran/widgets/student_page/PersonalStudent.dart';
import 'package:Quran/widgets/student_page/exam.dart';
import 'package:Quran/widgets/student_page/schedule/schedule.dart';
import 'package:flutter/material.dart';

import '../../pages/Signup.dart';
import '../../pages/Student_table.dart';
import '../../pages/teacherPage.dart';
import '../Teacher_page/PersonalInfo/personal_information.dart';
import '../Teacher_page/Student/student_informatin.dart';
import '../Teacher_page/report/lecture/Lecture.dart';

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
    'icon': Icon(Icons.picture_in_picture),
    'go': posts()
  },
   {
    'page': 'البيانات الشخصية',
    'icon': Icon(Icons.picture_in_picture),
    'go': Personal_student()
  },
  {
    'page': 'صفحة المدرس',
    'icon': Icon(Icons.picture_in_picture),
    'go': teacher_page()
  },
  
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
  {
    'page': 'الامتحانات',
    'icon': Icon(Icons.picture_in_picture),
    'go': ful_info()
  },
   {
    'page': 'البيانات الشخصية',
    'icon': Icon(Icons.picture_in_picture),
    'go': Personal_info()
  },
  {
    'page': 'صفحة الطالب',
    'icon': Icon(Icons.picture_in_picture),
    'go': student_page()
  },
  
   {
    'page': 'بيانات الطلاب',
    'icon': Icon(Icons.picture_in_picture),
    'go': student_Data()
  },
  {
    'page': 'إضافة الطلاب',
    'icon': Icon(Icons.picture_in_picture),
    'go': Signup()
  },
  {
    'page': 'إضافة أستاذ مساعد',
    'icon': Icon(Icons.picture_in_picture),
    'go': Signup()
  },
  
  

  {'page': 'تسجيل الخروج ', 'icon': Icon(Icons.exit_to_app), 'go': posts()}
];

class drawer extends StatefulWidget {
  String image, name, email;
  double drawer_width;
  bool student;

  drawer(
      {Key myKey,
      this.name,
      this.image,
      this.email,
      this.student,
      this.drawer_width})
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
                  child: Image.asset(widget.image),
                ),
                accountName: Text(widget.name),
                accountEmail: Text(widget.email)),
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
                      onTap: () {
                        Navigator.pop(context);

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
