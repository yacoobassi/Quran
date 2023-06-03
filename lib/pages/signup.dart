import 'package:flutter/material.dart';

import '../PagesWidgets/sign_up/largePage.dart';
import '../PagesWidgets/sign_up/smallPage.dart';

Icon eye = Icon(Icons.remove_red_eye_outlined);
bool presed = false;
bool saveUser = false, isloading = false;
double x, y, fontSize;

class Signup extends StatefulWidget {
  bool teacher;
  Signup(this.teacher);
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Loading() {
    setState(() {
      isloading = !isloading;
    });
  }

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
        child: SingleChildScrollView(
            child: screen < 750
                ? isloading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : small(Loading, widget.teacher)
                : isloading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : big(Loading, widget.teacher)),
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
