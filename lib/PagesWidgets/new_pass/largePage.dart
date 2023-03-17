import 'package:flutter/material.dart';

import '../../pages/new_pass.dart';
import '../../title.dart';
import '../sign_in/enter.dart';

class big extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 200;
    y = 250;
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 200, minWidth: 100),
                child: icon()),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 450, minWidth: 100),
              child: Column(
                children: [
                  title(
                      "تغيير كلمة السر",
                      "images/unlocked.png",
                      "حاول استخدام كلمة سر سهلة ولا يمكن لغيرك ان يعرفها",
                      "",
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
          ]),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
