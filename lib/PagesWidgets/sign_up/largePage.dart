import 'package:flutter/material.dart';

import '../../pages/signup.dart';
import '../../title.dart';
import 'package:test_ro_run/PagesWidgets/sign_up/enter.dart';

class big extends StatelessWidget {
  Function Loading;
  bool teacher;
  big(this.Loading, this.teacher);
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
                    enter(Loading, teacher),
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
