import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_stats/string_stats.dart';
import 'package:test_ro_run/PagesWidgets/sign_in/save.dart';
import 'package:test_ro_run/pages/stdPage.dart';
import 'package:test_ro_run/pages/teacherPage.dart';
import '../../FiledIconButton.dart';
import 'package:test_ro_run/User/getUser.dart';

import '../../User/Data.dart';

class enter extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';

  @override
  ConsumerState<enter> createState() => _enterState();
}

class _enterState extends ConsumerState<enter> {
  final GlobalKey<FormState> _logInKey = GlobalKey<FormState>();

  final TextEditingController _IdController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  Icon posticon;
  bool visible = false, isloading = false;
  swapIcon() {
    posticon = visible
        ? Icon(Icons.remove_red_eye_outlined)
        : Icon(Icons.remove_red_eye_rounded);

    visible = !visible;
    setState(() {});
  }

  @override
  void initState() {
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
          key: _logInKey,
          child: Column(
            children: [
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) return 'يرجى ادخال رقم المرور ';

                  if (!val.isNumeric) return 'الرقم غير صحيح';
                  return null;
                },
                controller: _IdController,
                decoration: filedDecoration("رقم المرور", Icon(Icons.email)),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _pwdController,
                obscureText: !visible,
                decoration: filedDecoration("كلمة السر", Icon(Icons.key)),
              ),
            ],
          ),
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
              onPressed: () async {
                final _auth = await FirebaseAuth.instance;
                try {
                  if (this._logInKey.currentState.validate()) {
                    await _auth.signInWithEmailAndPassword(
                        email: _IdController.text + "@gmail.com",
                        password: _pwdController.text);

                    await GetUser.userSignedIn(
                        _IdController.text + "@gmail.com");
                    Data.user.password = _pwdController.text;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return _IdController.text.length != 5
                          ? student_page()
                          : teacher_page();
                    }));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("البيانات المدخلة غير صحيحة  ")));
                }
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
