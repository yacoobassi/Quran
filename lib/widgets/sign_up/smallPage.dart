import 'package:Quran/widgets/sign_up/enter.dart';
import 'package:flutter/material.dart';

import '../../pages/signup.dart';
import '../../title.dart';

class small extends StatelessWidget {
  Function load;
  small({Key myKey, this.load}) : super(key: myKey);
  @override
  Widget build(BuildContext context) {
    x = 120;
    y = 136;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title("إنشاء حساب طالب جديد", "images/man.png", "", "", fontSize),
        icon(),
        enter(load: load),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
