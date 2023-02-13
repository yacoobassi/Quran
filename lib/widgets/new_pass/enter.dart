import 'package:flutter/material.dart';

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
            text: "كلمة السر الجديدة", icon: Icon(Icons.key), password: true),
        SizedBox(
          height: 20,
        ),
        textFiled(
            text: "اعادة كلمة السر", icon: Icon(Icons.key), password: true),
        SizedBox(
          height: 50,
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
                "تأكيد",
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
