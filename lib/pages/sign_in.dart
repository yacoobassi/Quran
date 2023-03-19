import 'package:flutter/material.dart';

import '../PagesWidgets/sign_in/largePage.dart';
import '../PagesWidgets/sign_in/smallPage.dart';

Icon eye;
bool presed = false;
double x, y;

class Signin extends StatefulWidget {
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  void initState() {
    super.initState();
    eye = Icon(Icons.remove_red_eye_outlined);
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: null,
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30, right: 10, left: 10),
        child: SingleChildScrollView(child: screen < 750 ? small() : big()),
      ),
    );
  }
}

Widget icon() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    child: Image.asset(
      "images/logo.png",
      width: x,
      height: y,
    ),
  );
}
