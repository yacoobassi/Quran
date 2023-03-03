import 'package:Quran/pages/sign_in.dart';
import 'package:Quran/pages/signup.dart';
import 'package:Quran/pages/stdPage.dart';
import 'package:flutter/material.dart';

class Athunticate extends StatefulWidget {
  @override
  State<Athunticate> createState() => _nameState();
}

class _nameState extends State<Athunticate> {
  bool showsignIn = true;

  toggle() {
    setState(() {
      showsignIn = !showsignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showsignIn ? Signin() : student_page();
  }
}
