import 'package:Quran/title.dart';
import 'package:flutter/material.dart';

class newPass extends StatefulWidget {
  @override
  State<newPass> createState() => _newPassState();
}

class _newPassState extends State<newPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(children: [
          title("تغيير كلمة السر", "images/unlocked.png"),
        ]),
      )),
    );
  }
}
