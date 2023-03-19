import 'package:flutter/material.dart';
import 'package:test_ro_run/Chat/screens/auth_screen.dart';
import 'package:test_ro_run/pages/sign_in.dart';

import '../../FiledIconButton.dart';
import 'package:loader_overlay/loader_overlay.dart';

class enter extends StatefulWidget {
  @override
  State<enter> createState() => _enterState();
}

class _enterState extends State<enter> {
  Icon posticon;
  bool visible = false;
  bool _isLoading = false;
  TextEditingController nameController = new TextEditingController();
  TextEditingController PhoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  //final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();

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
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: this._isLoading,
      child: Column(
        children: [
          Form(
            key: _signUpKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) {
                    RegExp regExp = RegExp(" ");

                    if (val.isEmpty) return 'يرجى ادخال الاسم';
                    if (regExp.allMatches(val).length + 1 < 4)
                      return 'يرجى ادخال الاسم الرباعي';

                    return null;
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
                    return null;
                  },
                  controller: PhoneController,
                  decoration: filedDecoration(
                      "رقم جوال ولي الأمر", Icon(Icons.numbers)),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                    validator: (val) {
                      if (val.isEmpty) return 'يرجى ادخال كلمة السر';
                      if (val.length < 6)
                        return 'يرجى ادخال كلمة سر تزيد عن 5 احرف';

                      return null;
                    },
                    controller: passwordController,
                    obscureText: !visible,
                    decoration: filedDecoration("كلمة السر", Icon(Icons.key))),
              ],
            ),
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
                  //if (this._signUpKey.currentState.validate()) {
                  if (mounted) {
                    setState(() {
                      this._isLoading = true;
                    });
                  }
                  showDialog(
                      context: context,
                      builder: (con) {
                        return AlertDialog(
                          actions: [
                            ElevatedButton(
                                onPressed: () async {
                                  SignNewUser.signUpFunction(
                                      nameController.text,
                                      PhoneController.text + "@gmail.com");

                                  // final EmailSignUpResults response =
                                  //     await this
                                  //         ._emailAndPasswordAuth
                                  //         .signUpAuth(
                                  //             email: PhoneController.text +
                                  //                 "@google.com",
                                  //             pwd: passwordController.text);

                                  // if (response ==
                                  //     EmailSignUpResults.SignUpCompleted) {
                                  //   Navigator.push(context,
                                  //       MaterialPageRoute(builder: (context) {
                                  //     return ChatsScreen();
                                  //   }));
                                  // } else {
                                  //   final String msg = response ==
                                  //           EmailSignUpResults
                                  //               .EmailAlreadyPresent
                                  //       ? ''
                                  //       : 'لم يكتمل االتسجيل';
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(
                                  //           SnackBar(content: Text(msg)));
                                  // }
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Signin();
                                  }));
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
                            "رقم الطالب هو : ",
                            softWrap: true,
                          ),
                        );
                      });
                  // }
                  if (mounted) {
                    setState(() {
                      this._isLoading = false;
                    });
                  }
                },
                child: Text(
                  "إنشاء الحساب",
                  style: TextStyle(fontSize: 20),
                )),
          ),
        ],
      ),
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
