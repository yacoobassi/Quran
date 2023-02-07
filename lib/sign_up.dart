import 'package:flutter/material.dart';

import 'title.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30, right: 20, left: 20),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                title("أنشئ حسابا على اقرأ", "images/pencil.png",
                    "انضم الان الى تطبيق اقرأ", ""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
