import 'package:flutter/material.dart';

import '../../Links.dart';
import '../../pages/new_pass.dart';
import '../../request.dart';
import '../../title.dart';
import '../new_pass/enter.dart';

class small extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 120;
    y = 136;
    return Column(
      children: [
        title(" تأكيد هويتك", "images/unlocked.png",
            "سيتم ارسال رسالة الى رقم هاتفك", "", 35),
        SizedBox(
          height: 20,
        ),
        icon(),
        SizedBox(
          height: 20,
        ),
        enter(),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
