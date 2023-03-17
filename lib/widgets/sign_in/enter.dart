import 'package:flutter/material.dart';

import '../../PagesWidgets/sign_in/save.dart';
import '../../textfiled.dart';

class enter extends StatefulWidget {
  @override
  State<enter> createState() => _enterState();
}

class _enterState extends State<enter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textFiled(text: "رقم الطالب", icon: Icon(Icons.email), password: false),
        SizedBox(
          height: 15,
        ),
        textFiled(text: "كلمة السر", icon: Icon(Icons.key), password: true),
        SizedBox(
          height: 12,
        ),
        save(),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )),
              ),
              onPressed: () {},
              child: Text(
                "تسجيل الدخول",
                style: TextStyle(fontSize: 20),
              )),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
