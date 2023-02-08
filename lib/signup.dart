import 'dart:html';

import 'package:Quran/new_pass.dart';
import 'package:flutter/material.dart';
import 'title.dart';

Icon eye = Icon(Icons.remove_red_eye_outlined);
bool presed = false;
bool saveUser = false;
double x, y, fontSize;

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    screen < 290 ? fontSize = 25 : fontSize = 35;
    return Scaffold(
      appBar: null,
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30, right: 15, left: 15),
        child: SingleChildScrollView(child: screen < 750 ? small() : big()),
      ),
    );
  }
}

class small extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 120;
    y = 136;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title("إنشاء حساب طالب جديد", "images/man.png", "", "", fontSize),
        icon(),
        enter(),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class big extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 250;
    y = 300;
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 450,
              ),
              child: Container(
                margin: EdgeInsets.only(right: 30),
                child: Column(
                  children: [
                    title("إنشاء حساب طالب جديد", "images/man.png", "", "", 35),
                    SizedBox(
                      height: 60,
                    ),
                    enter(),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
            ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 200,
                ),
                child: icon())
          ]),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}

Widget icon() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    child: Image.asset(
      "images/quran.png",
      width: x,
      height: y,
    ),
  );
}

class enter extends StatefulWidget {
  @override
  State<enter> createState() => _enterState();
}

class _enterState extends State<enter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Form(
              child: TextFormField(
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              hintText: "الاسم الرباعي",
              suffixIcon: Icon(Icons.abc),
              filled: true,
              fillColor: Colors.grey[280],
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300])),
            ),
          )),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 50,
          child: Form(
              child: TextFormField(
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              hintText: "رقم جوال ولي الأمر",
              suffixIcon: Icon(Icons.numbers),
              filled: true,
              fillColor: Colors.grey[280],
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300])),
            ),
          )),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 50,
          child: Form(
            child: TextFormField(
              obscureText: !presed,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                hintText: "كلمة السر",
                suffixIcon: Icon(Icons.key),
                prefixIcon: IconButton(
                  icon: eye,
                  onPressed: () {
                    setState(() {
                      if (!presed)
                        eye = Icon(Icons.remove_red_eye_rounded);
                      else
                        eye = Icon(Icons.remove_red_eye_outlined);

                      presed = !presed;
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.grey[280],
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (con) {
                      return AlertDialog(
                        actions: [
                          ElevatedButton(
                              onPressed: () {}, child: Text("إلغاء")),
                          ElevatedButton(onPressed: () {}, child: Text("تأكيد"))
                        ],
                        title: Text(
                          "تأكيد التسجيل",
                          style: TextStyle(),
                          textDirection: TextDirection.rtl,
                        ),
                        content: Text(
                          "رقم الطالب هو : $x",
                          textDirection: TextDirection.rtl,
                          softWrap: true,
                        ),
                      );
                    });
              },
              child: Text(
                "إنشاء الحساب",
                style: TextStyle(fontSize: 20),
              )),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
