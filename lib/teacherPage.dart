import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

int messagesNum = 5, selected = 2;
double opacity = 1;

class teacher_page extends StatefulWidget {
  @override
  State<teacher_page> createState() => _teacher_pageState();
}

class _teacher_pageState extends State<teacher_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                onDetailsPressed: () {},
                currentAccountPicture: ClipOval(
                  child: Image.asset("images/face.jpg"),
                ),
                accountName: Text("Mohammad"),
                accountEmail: Text("Mohammad@hotmail.com")),
            ListTile(
              title: Text(
                "الصفحة الرئيسية",
                textDirection: TextDirection.rtl,
              ),
              trailing: Icon(Icons.home),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "التقرير الشهري",
                textDirection: TextDirection.rtl,
              ),
              trailing: Icon(Icons.date_range),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "جداول الحفظ",
                textDirection: TextDirection.rtl,
              ),
              trailing: Icon(Icons.table_chart_outlined),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "المنشورات",
                textDirection: TextDirection.rtl,
              ),
              trailing: Icon(Icons.post_add),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "الطلاب",
                textDirection: TextDirection.rtl,
              ),
              trailing: Icon(Icons.people),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "التواصل مع الأهل",
                textDirection: TextDirection.rtl,
              ),
              trailing: Icon(Icons.email_rounded),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "ألبوم الصور",
                textDirection: TextDirection.rtl,
              ),
              trailing: Icon(Icons.picture_in_picture),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.email),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          )
        ],
        title: Text(
          "صفحة المدرس",
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.green,
      ),
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
                label: "التقرير الشهري", icon: Icon(Icons.content_paste)),
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
        /*
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
        */
        SizedBox.fromSize(
          size: Size(10, 10),
        ),
        Row(
          textDirection: TextDirection.rtl,
          children: [
            name(),
            Container(
              transformAlignment: Alignment.bottomRight,
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
