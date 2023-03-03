import 'package:Quran/newChating/Screen_Chats/chat_screen.dart';
import 'package:Quran/newChating/firebase/services/shared.dart';
import 'package:Quran/pages/stdPage.dart';
import 'package:Quran/newChating/firebase/services/database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../FiledIconButton.dart';
import '../../pages/Signup.dart';
import '../../newChating/firebase/services/auth.dart';
import '../../textfiled.dart';
import 'package:Quran/newChating/firebase/services/database.dart';

class enter extends StatefulWidget {
  Function load;
  enter({Key myKey, this.load}) : super(key: myKey);
  @override
  State<enter> createState() => _enterState();
}

class _enterState extends State<enter> {
  Icon posticon;
  bool visible, isloading;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final formkey = GlobalKey<FormState>();
  DataBase database = new DataBase();
  Auth auth = new Auth();

  swapIcon() {
    posticon = visible
        ? Icon(Icons.remove_red_eye_outlined)
        : Icon(Icons.remove_red_eye_rounded);

    visible = !visible;
    setState(() {});
  }

  signStudentUp() {
    if (formkey.currentState.validate()) {
      widget.load();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    posticon = Icon(Icons.remove_red_eye_outlined);
    visible = false;
    isloading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                validator: (val) {
                  RegExp regExp = RegExp(" ");

                  if (val.isEmpty) return 'يرجى ادخال الاسم';
                  if (regExp.allMatches(val).length + 1 < 4)
                    return 'يرجى ادخال الاسم الرباعي';
                },
                controller: nameController,
                decoration: filedDecoration("الاسم الرباعي", Icon(Icons.abc)),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (val) {
                  RegExp regExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                  if (val.isEmpty) return 'يرجى ادخال رقم الهاتف';

                  if (!regExp.hasMatch(val)) return 'الرقم غير صحيح';
                },
                controller: emailController,
                decoration:
                    filedDecoration("رقم جوال ولي الأمر", Icon(Icons.numbers)),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  validator: (val) {
                    if (val.isEmpty) return 'يرجى ادخال كلمة السر';
                    if (val.length < 6)
                      return 'يرجى ادخال كلمة سر تزيد عن 5 احرف';
                  },
                  controller: passwordController,
                  obscureText: !visible,
                  decoration: filedDecoration("كلمة السر", Icon(Icons.key))),
            ],
          ),
        ),
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
                              onPressed: () {
                                Navigator.pop(context);
                                signStudentUp();
                                auth
                                    .signup(emailController.text,
                                        passwordController.text)
                                    .then((value) {
                                  Map<String, String> studentMap = {
                                    "name": nameController.text,
                                    "email": emailController.text,
                                    //  "password":passwordController.text
                                  };
                                  helper.saveUserEmail(emailController.text);
                                  helper.saveUserName(nameController.text);
                                  database.uploadStudentInfo(studentMap);
                                  helper.saveUserLoggedIn(true);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ChatsScreen()));
                                });
                              },
                              child: Text("تأكيد")),
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
