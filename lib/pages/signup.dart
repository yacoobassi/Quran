import 'package:flutter/material.dart';

import '../widgets/sign_up/largePage.dart';
import '../widgets/sign_up/smallPage.dart';

Icon eye = Icon(Icons.remove_red_eye_outlined);
bool presed;
bool saveUser, isloading;

double x, y, fontSize;

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presed = false;
    saveUser = false;
    isloading = false;
  }

  load() {
    isloading = true;
    setState(() {});
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
        child: !isloading
            ? SingleChildScrollView(
                child: screen < 750 ? small(load: load) : big(load: load))
            : Center(
                child: CircularProgressIndicator(),
              ),
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
