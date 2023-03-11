import 'package:flutter/material.dart';

import '../../pages/Signup.dart';
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
        textFiled(
            text: "الاسم الرباعي", icon: Icon(Icons.abc), password: false),
        SizedBox(
          height: 15,
        ),
        textFiled(
            text: "رقم جوال ولي الأمر",
            icon: Icon(Icons.numbers),
            password: false),
        SizedBox(
          height: 15,
        ),
        textFiled(text: "كلمة السر", icon: Icon(Icons.key), password: true),
        SizedBox(
          height: 20,
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
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (con) {
                      return AlertDialog(
                        actions: [
                          ElevatedButton(
                              onPressed: () {}, child: Text("تأكيد")),
                          ElevatedButton(
                              onPressed: () {}, child: Text("إلغاء")),
                        ],
                        title: Text(
                          "تأكيد التسجيل",
                          style: TextStyle(),
                        ),
                        content: Text(
                          "رقم الطالب هو : $x",
                          softWrap: true,
                        ),
                      );
                    });
              },
              child: Text(
                "إنشاء الحساب",
                style: TextStyle(fontSize: 20),
              )),
        ),
      ],
    );
  }
}
