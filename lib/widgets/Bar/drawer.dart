import 'package:Quran/pages/posts.dart';
import 'package:Quran/pages/sign_in.dart';
import 'package:Quran/newChating/firebase/services/auth.dart';
import 'package:flutter/material.dart';

var Studentlist = [
  {'page': 'الصفحة الرئيسية', 'icon': Icon(Icons.home), 'go': posts()},
  {
    'page': 'الامتحانات',
    'icon': Icon(Icons.pending_actions_outlined),
    'go': posts()
  },
  {'page': 'العلامات', 'icon': Icon(Icons.date_range), 'go': posts()},
  {
    'page': 'جدول الحفظ',
    'icon': Icon(Icons.table_chart_outlined),
    'go': posts()
  },
  {'page': 'المنشورات', 'icon': Icon(Icons.post_add), 'go': posts()},
  {
    'page': 'البوم الصور',
    'icon': Icon(Icons.picture_in_picture),
    'go': posts()
  },
  {'page': 'تسجيل الخروج ', 'icon': Icon(Icons.exit_to_app), 'go': posts()}
];

var teacherlist = [
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
  Auth auth = new Auth();
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

                        if (i == drawerlist.length - 1) {
                          auth.signout();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Signin();
                          }));
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
