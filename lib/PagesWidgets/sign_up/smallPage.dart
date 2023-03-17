import 'package:flutter/material.dart';

import '../../pages/signup.dart';
import '../../title.dart';
import 'package:test_ro_run/PagesWidgets/sign_up/enter.dart';

class small extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 120;
    y = 136;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title("إنشاء حساب طالب جديد", "images/man.png", "", "", fontSize),
        icon(),
        enter(),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
