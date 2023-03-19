import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_ro_run/PagesWidgets/sign_in/save.dart';
import 'package:test_ro_run/pages/stdPage.dart';
import '../../FiledIconButton.dart';

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
          key: _logInKey,
          child: Column(
            children: [
              TextFormField(
                validator: (val) {
                  RegExp regExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                  if (val.isEmpty) return 'يرجى ادخال رقم الهاتف';

                  if (!regExp.hasMatch(val)) return 'الرقم غير صحيح';
                  return null;
                },
                controller: _IdController,
                decoration: filedDecoration("رقم الطالب", Icon(Icons.email)),
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
                  await _auth.signInWithEmailAndPassword(
                      email: _IdController.text + "@gmail.com",
                      password: "password");

                  DocumentSnapshot snap = await FirebaseFirestore.instance
                      .collection("users")
                      .doc(_IdController.text + "@gmail.com")
                      .get();

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return student_page();
                  }));
                  // if (this._logInKey.currentState.validate()) {
                  //   print('Validated');

                  //   if (mounted) {
                  //     setState(() {
                  //       isloading = true;
                  //     });
                  //   }

                  //   final EmailSignInResults emailSignInResults =
                  //       await _emailAndPasswordAuth.signInWithEmailAndPassword(
                  //           email: this._IdController.text + "@gmail.com",
                  //           pwd: this._pwdController.text);

                  //   String msg = '';
                  //   if (emailSignInResults ==
                  //       EmailSignInResults.SignInCompleted)
                  //     Navigator.pushAndRemoveUntil(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (_) => ChatAndActivityScreen()),
                  //         (route) => false);
                  //   else if (emailSignInResults ==
                  //       EmailSignInResults.EmailNotVerified) {
                  //     msg =
                  //         'الحساب غير موجود تأكد من ادخال الرقم بالشكل الصحيح';
                  //   } else if (emailSignInResults ==
                  //       EmailSignInResults.EmailOrPasswordInvalid)
                  //     msg = 'الرقم وكلمة السر غير خطأ';
                  //   else
                  //     msg = 'خطأ في البيانات';

                  //   if (msg != '')
                  //     ScaffoldMessenger.of(context)
                  //         .showSnackBar(SnackBar(content: Text(msg)));

                  //   if (mounted) {
                  //     setState(() {
                  //       this.isloading = false;
                  //     });
                  //   }
                  // } else {
                  //   print('Not Validated');
                  // }
                } catch (e) {}
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
