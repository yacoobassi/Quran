import 'package:flutter/material.dart';

import '../PagesWidgets/sign_up/largePage.dart';
import '../PagesWidgets/sign_up/smallPage.dart';

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
