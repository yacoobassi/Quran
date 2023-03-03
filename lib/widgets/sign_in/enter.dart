import 'package:Quran/newChating/firebase/services/database.dart';
import 'package:Quran/newChating/firebase/services/shared.dart';
import 'package:Quran/widgets/sign_in/save.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../FiledIconButton.dart';
import '../../newChating/Screen_Chats/chat_screen.dart';
import '../../newChating/firebase/services/auth.dart';
import '../../textfiled.dart';

class enter extends StatefulWidget {
  @override
  State<enter> createState() => _enterState();
}

class _enterState extends State<enter> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwodController = new TextEditingController();
  DataBase database = new DataBase();
  final formkey = GlobalKey<FormState>();
  Auth auth = new Auth();
  QuerySnapshot snapshot;

  Icon posticon;
  bool visible = false;
  swapIcon() {
    posticon = visible
        ? Icon(Icons.remove_red_eye_outlined)
        : Icon(Icons.remove_red_eye_rounded);

    visible = !visible;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    posticon = Icon(Icons.remove_red_eye_outlined);
    visible = false;
  }

  bool isloading = false;
  signIn() {
    helper.saveUserEmail(emailController.text);

    setState(() {
      isloading = true;
    });
    database.getStudentByEmail(emailController.text).then((val) {
      snapshot = val;
      helper.saveUserName(snapshot.docs[0].get('name'));
    });

    auth.signIn(emailController.text, passwodController.text).then((value) {
      helper.saveUserLoggedIn(true);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatsScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: filedDecoration("رقم الطالب", Icon(Icons.email)),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passwodController,
                obscureText: !visible,
                decoration: filedDecoration("كلمة السر", Icon(Icons.key)),
              ),
            ],
          ),
        ),
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
              onPressed: () {
                signIn();
              },
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

  InputDecoration filedDecoration(String text, Icon preIcon) {
    return InputDecoration(
      hintText: "$text",
      prefixIcon: preIcon,
      suffixIcon: text == "كلمة السر"
          ? FiledIconButton(icon: posticon, swapicon: swapIcon)
          : Icon(null),
      filled: true,
      fillColor: Colors.grey[280],
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300])),
    );
  }
}
