import 'package:flutter/material.dart';

import '../PagesWidgets/new_pass/largePage.dart';
import '../PagesWidgets/new_pass/smallPage.dart';

double x, y;
Icon eye1 = Icon(Icons.remove_red_eye_outlined), eye2 = eye1;
bool presed1 = false, presed2 = false;

class newPass extends StatefulWidget {
  @override
  State<newPass> createState() => _newPassState();
}

class _newPassState extends State<newPass> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(child: screen < 750 ? small() : big()),
      ),
    ));
  }
}

Widget icon() {
  return Container(
    width: x,
    height: y,
    child: Image.asset("images/padlock.png"),
  );
}
