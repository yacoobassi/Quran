import 'package:Quran/sign_in.dart';
import 'package:Quran/stdPage.dart';
import 'package:Quran/teacherPage.dart';
import 'package:flutter/material.dart';

main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Quran",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Hacen"),
        home: teacher_page());
  }
}
