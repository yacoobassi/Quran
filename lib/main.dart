import 'package:Quran/pages/Student_table.dart';
import 'package:Quran/pages/new_pass.dart';
import 'package:Quran/pages/posts.dart';
import 'package:Quran/pages/sign_in.dart';
import 'package:Quran/pages/signup.dart';
import 'package:Quran/pages/stdPage.dart';
import 'package:Quran/pages/teacherPage.dart';
import 'package:Quran/widgets/Teacher_page/Exams/full_info.dart';
import 'package:Quran/widgets/Teacher_page/Exams/fulltable.dart';
import 'package:Quran/widgets/Teacher_page/Exams/grade.dart';
import 'package:Quran/widgets/Teacher_page/PersonalInfo/personal_information.dart';
import 'package:Quran/widgets/Teacher_page/Student/student_informatin.dart';
import 'package:Quran/widgets/Teacher_page/report/table/grades.dart';
import 'package:Quran/widgets/student_page/PersonalStudent.dart';
import 'package:Quran/widgets/student_page/exam.dart';
import 'package:Quran/widgets/student_page/schedule/schedule.dart';
import 'package:flutter/material.dart';
import 'package:Quran/widgets/Teacher_page/report/lecture/Lecture.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'newChating/Screen_Chats/chat_screen.dart';

main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Quran",
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale('ar', 'US')],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Hacen"),
        home: teacher_page());
  }
}
