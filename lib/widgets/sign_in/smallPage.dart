import 'package:Quran/title.dart';
import 'package:Quran/widgets/sign_in/enter.dart';
import 'package:flutter/material.dart';

import '../../pages/sign_in.dart';

class small extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 120;
    y = 136;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title("تسجيل الدخول", "images/handshake.png",
            "نحن في انتظارك في اقرأ سجل الان", "images/love.png", 35),
        icon(),
        enter(),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
