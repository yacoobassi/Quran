import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

import '../../Links.dart';
import '../../User/Data.dart';
import '../../User/getUser.dart';
import '../../pages/stdPage.dart';
import '../../pages/teacherPage.dart';
import '../../request.dart';

class enter extends StatefulWidget {
  @override
  State<enter> createState() => _enterState();
}

class _enterState extends State<enter> {
  Requst request = new Requst();
  TextEditingController number = new TextEditingController();
  TextEditingController message = new TextEditingController();
  String random;

  List<String> phones = [];
  getPhoneNum() async {
    var response = await request.postRequest(getPhoneNumber, {
      "num": number.text,
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: number,
          validator: (val) {
            RegExp regExp = RegExp(" ");

            if (val.isEmpty) return 'يرجى ادخال الاسم';
            if (regExp.allMatches(val).length + 1 < 4)
              return 'يرجى ادخال الاسم الرباعي';

            return null;
          },
          decoration: filedDecoration("رقم المرور", Icon(Icons.abc)),
        ),
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
                ),
              ),
            ),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (con) {
                  return FutureBuilder(
                    future: getPhoneNum(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(
                            snapshot.data['data'][0]['fatherPhone'])) {
                          phones.add(snapshot.data['data'][0]['fatherPhone']);
                        }
                        if (RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(
                            snapshot.data['data'][0]['motherPhone'])) {
                          phones.add(snapshot.data['data'][0]['motherPhone']);
                        }
                        random = "${Random().nextInt(90000) + 10000}";
                        sendSMS(
                          message: random,
                          recipients: phones,
                        );
                        return AlertDialog(
                          content: TextField(controller: message),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                if (message.text == random) {
                                  final _auth = await FirebaseAuth.instance;

                                  await _auth.signInWithEmailAndPassword(
                                      email: "${number.text}@gmail.com",
                                      password: snapshot.data['data'][0]
                                          ['password']);

                                  await GetUser.userSignedIn(
                                      "${number.text}@gmail.com");
                                  Data.user.password =
                                      snapshot.data['data'][0]['password'];
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return number.text.length != 5
                                        ? student_page()
                                        : teacher_page();
                                  }));
                                }
                              },
                              child: Text("تأكيد"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("إلغاء"),
                            ),
                          ],
                          title: Text(
                            "ادخل الرقم المرسل الى هاتفك",
                            style: TextStyle(),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                },
              );
            },
            child: Text(
              "ارسال",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

InputDecoration filedDecoration(String text, Icon preIcon) {
  return InputDecoration(
    hintText: "$text",
    filled: true,
    fillColor: Colors.grey[280],
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300])),
  );
}

void _sendSMS(String message, List<String> recipents) async {
  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
}
