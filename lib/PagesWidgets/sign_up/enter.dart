import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/Chat/screens/auth_screen.dart';
import 'package:test_ro_run/request.dart';
import 'package:test_ro_run/Links.dart';
import '../../FiledIconButton.dart';
import '../../User/Data.dart';
import '../../User/getUser.dart';

class enter extends StatefulWidget {
  @override
  enter(this.Loading, this.teacher);
  Function Loading;
  bool teacher;

  State<enter> createState() => _enterState();
}

class _enterState extends State<enter> {
  Icon posticon;
  bool visible = false;
  bool _isLoading = false;
  String num;
  Requst request = new Requst();
  TextEditingController nameController = new TextEditingController();
  TextEditingController PhoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  //final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();

  signup() async {
    // widget.Loading();

    if (widget.teacher) {
      print("object3");
      var response1 = await request.postRequest(linkTeacherSignup, {
        "password": passwordController.text,
        "num": num,
      });

      //widget.Loading();

      var response2 = await request.postRequest(linkTeacherData, {
        "name": nameController.text,
        "id": "",
        "country": "",
        "birth": "",
        "social": "غير متزوج",
        "currentJob": "",
        "lastJob": "",
        "study": "",
        "university": "",
        "certificate": "",
        "tajoeedLevel": "",
        "tajoeedYear": "أتقن التجويد وليس معي شهادة",
        "mosque": "",
        "personTeachYou": "",
        "region": "",
        "Yourphone": "",
        "housePhone": "",
        "remark": "",
        "num": num
      });

      if (response1['status'] == "success" &&
          response2['status'] == "success") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("تمت اضافة الاستاذ")));
        await SignNewUser.signUpFunction(
            nameController.text,
            num + "@gmail.com",
            false,
            Data.user.institute.toString(),
            Data.user.regiment,
            passwordController.text,
            Data.user.inistituteName);
      } else
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("لم يتم التسجيل")));
    } else {
      var response1 = await request.postRequest(linkStudentSignup, {
        "name": nameController.text,
        "password": passwordController.text,
        "num": num,
        "groupNum": "1",
        "instituteNum": Data.user.institute,
        "reginmentNum": Data.user.regiment,
      });

      var response2 = await request.postRequest(linkStData, {
        "num": num,
        "currentPart": "",
        "nextExam": "",
        "grade": "",
        "birth": "",
        "fatherPhone": PhoneController.text,
        "motherPhone": "",
        "house": "",
        "instituteName": "مركز بلاطة",
        "instituteNum": Data.user.institute.toString(),
        "finishedParts": "0",
      });

      //widget.Loading();

      if (response1['status'] == "success" &&
          response2['status'] == "success") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("تمت اضافة الطالب")));
        String user = Data.user.email;
        String password = Data.user.password;

        await SignNewUser.signUpFunction(
            nameController.text,
            num + "@gmail.com",
            true,
            Data.user.institute,
            Data.user.regiment,
            passwordController.text,
            Data.user.inistituteName);

        final _auth = await FirebaseAuth.instance;

        //await _auth.signInWithEmailAndPassword(email: user, password: password);

        await GetUser.userSignedIn(user);

        nameController.clear();
        PhoneController.clear();
        passwordController.clear();
      } else
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("لم يتم التسجيل")));
    }
  }

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
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                if (this._signUpKey.currentState.validate()) {
                  if (mounted) {
                    setState(() {
                      this._isLoading = true;
                    });
                  }
                  Random random = Random();

                  int min = 100;
                  int max = 999;

                  int rand = min + random.nextInt(max - min + 1);

                  num = "${Data.user.regiment}${Data.user.institute}$rand";

                  showDialog(
                      context: context,
                      builder: (con) {
                        return AlertDialog(
                          actions: [
                            ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await signup();
                                },
                                child: Text("تأكيد")),
                            ElevatedButton(
                                onPressed: () async {}, child: Text("إلغاء")),
                          ],
                          title: Text(
                            "تأكيد التسجيل",
                            style: TextStyle(),
                          ),
                          content: Text(
                            "رقم الطالب هو : $num",
                            softWrap: true,
                          ),
                        );
                      });
                }
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
