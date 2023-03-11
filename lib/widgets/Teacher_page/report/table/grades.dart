import 'package:Quran/widgets/Teacher_page/report/lecture/Lecture.dart';
import 'package:Quran/widgets/Teacher_page/report/lecture/dropdown.dart';
import 'package:Quran/widgets/Teacher_page/report/lecture/navigator_buttom.dart';
import 'package:Quran/widgets/Teacher_page/report/table/bottom_table.dart';
import 'package:Quran/widgets/Teacher_page/report/table/gettable.dart';
import 'package:flutter/material.dart';

import '../../../../pages/posts.dart';
import '../../../Bar/drawer.dart';
import '../../../Bar/notification.dart';

class grades extends StatefulWidget {
  @override
  State<grades> createState() => _gradesState();
}

DateTime date = DateTime.now();
bool check = false;
List gruob = [
  "1",
  "2",
  "3",
  "4",
  "5",
];

List student = [
  "يعقوب عاصي",
  "يوسف مرعي",
  "أحمد أيمن",
  "رائد خويرة",
  "مصطفى فطاير }",
  "اياد جودة",
  "عبد الله الرفاعي"
];

class _gradesState extends State<grades> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
      
       drawer: drawer(
          student: false,
          email: "Yacoobassi8@gmai.com",
          name: "Yacoob assi",
          image: "images/face.jpg",
          drawer_width: drawer().drawer_width),
      endDrawer: notification(
        width: screen,
        text: likeORcomment,
      ),
      
      appBar: AppBar(
        title: Text(
          "التقرير الشهري ",
        ),
      ),
         bottomNavigationBar: nav_bottom(),
        body: ListView(scrollDirection: Axis.vertical, children: [
          Column(children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.green),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Text(
                " المجموعات",
                style: TextStyle(fontSize: 25),
              ),
              alignment: Alignment.center,
            ),
            Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "رقم المجموعة :      ",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      child: droplist(gruob, "1"),
                    )
                  ],
                )),
          ]),
          Container(
            width: 390,
            height: 1200,
            decoration: BoxDecoration(
              border: Border.all(width: 5),
            ),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, i) {
                  return Container(
                      child: Column(children: [
                    Container(
                      width: 400,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(border: Border.all(width: 7)),
                      child: Text(
                        "محمد عصام مسعود",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    gettable(),
                    bottomInfo(),
                    /*
                          ElevatedButton(
                              style: ButtonStyle(),
                              onPressed: () {
                                
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return bottomInfo();
                                }));
                              },
                              child: Text("نهاية الشهر"))
                              */
                  ]));
                }),
          )
        ]));
  }
}
