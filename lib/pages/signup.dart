import 'package:flutter/material.dart';
import '../textfiled.dart';
import '../title.dart';

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
                  maxWidth: 200,
                ),
                child: icon()),
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
        textFiled(
            text: "الاسم الرباعي", icon: Icon(Icons.abc), password: false),
        SizedBox(
          height: 15,
        ),
        textFiled(
            text: "رقم جوال ولي الأمر",
            icon: Icon(Icons.numbers),
            password: false),
        SizedBox(
          height: 15,
        ),
        textFiled(text: "كلمة السر", icon: Icon(Icons.key), password: true),
        SizedBox(
          height: 20,
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
                              onPressed: () {}, child: Text("تأكيد")),
                          ElevatedButton(
                              onPressed: () {}, child: Text("إلغاء")),
                        ],
                        title: Text(
                          "تأكيد التسجيل",
                          style: TextStyle(),
                        ),
                        content: Text(
                          "رقم الطالب هو : $x",
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
      ],
    );
  }
}
