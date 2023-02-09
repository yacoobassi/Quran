import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

int messagesNum = 5, selected = 2;
double opacity = 1;

class student_page extends StatefulWidget {
  @override
  State<student_page> createState() => _student_pageState();
}

class _student_pageState extends State<student_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [top()],
      )),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selected,
          onTap: (index) {
            setState(() {
              selected = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                label: "العلامات", icon: Icon(Icons.content_paste)),
            // BottomNavigationBarItem(
            //     label: "الامتحانات", icon: Icon(Icons.text_snippet)),
            BottomNavigationBarItem(
                label: "جدول الحفظ", icon: Icon(Icons.table_chart_outlined)),
            BottomNavigationBarItem(
                label: "الصفحة الرئيسية", icon: Icon(Icons.window_sharp)),
          ]),
    );
  }
}

class top extends StatefulWidget {
  @override
  State<top> createState() => _topState();
}

class _topState extends State<top> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      height: 150,
      color: Colors.green,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        
        InkWell(
          child: Badge(
            badgeContent: Text("$messagesNum"),
            showBadge: true,
            child: Container(
                width: 50, height: 50, child: Image.asset("images/chat.png")),
         ),
          onTap: () {
            setState(() {
              messagesNum++;
            });
            
          },
          
        ),
        
        Row(
          children: [
            name(),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: InkWell(
                child: ClipOval(
                    child: Image.asset(
                  "images/face.jpg",
                  color: Colors.white.withOpacity(opacity),
                  colorBlendMode: BlendMode.modulate,
                  height: 70.0,
                  width: 70.0,
                  fit: BoxFit.fill,
                )),
                onTap: () {},
                onHover: (val) {
                  setState(() {
                    if (val)
                      opacity = 0.5;
                    else
                      opacity = 1;
                  });
                },
              ),
            ),
          ],
        )
      ]),
    );
  }
}

Widget name() {
  return Row(
    children: [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "محمد مسعود",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        Row(children: [
          Container(
            width: 15,
            height: 15,
            child: Image.asset("images/heart.png"),
          ),
          Text(
            "  مرحبا بك",
            style: TextStyle(color: Colors.white),
          ),
        ]),
      ])
    ],
  );
}
