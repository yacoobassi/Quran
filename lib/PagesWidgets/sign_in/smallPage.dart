import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/sign_in/enter.dart';

import '../../pages/sign_in.dart';
import '../../title.dart';

class small extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 120;
    y = 136;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title(
            "تسجيل الدخول", "images/handshake.png", "", "images/love.png", 35),
        icon(),
        enter(),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
