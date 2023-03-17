import 'package:flutter/material.dart';
import 'package:test_ro_run/title.dart';

import '../../PagesWidgets/sign_in/enter.dart';
import '../../pages/sign_in.dart';

class big extends StatelessWidget {
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
                    title(
                        "تسجيل الدخول",
                        "images/handshake.png",
                        "نحن في انتظارك في اقرأ سجل الان",
                        "images/love.png",
                        35),
                    SizedBox(
                      height: 60,
                    ),
                    enter(),
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
