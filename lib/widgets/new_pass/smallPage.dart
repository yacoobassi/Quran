import 'package:flutter/material.dart';
import 'package:test_ro_run/title.dart';

import '../../PagesWidgets/new_pass/enter.dart';
import '../../pages/new_pass.dart';

class small extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 120;
    y = 136;
    return Column(
      children: [
        title("تغيير كلمة السر", "images/unlocked.png",
            " استخدم كلمة سر سهلة ولا يمكن لغيرك ان يعرفها", "", 35),
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
