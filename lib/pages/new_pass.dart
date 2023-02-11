import 'package:Quran/pages/sign_in.dart';
import 'package:Quran/title.dart';
import 'package:flutter/material.dart';

import '../textfiled.dart';

double x, y;
Icon eye1 = Icon(Icons.remove_red_eye_outlined), eye2 = eye1;
bool presed1 = false, presed2 = false;

class newPass extends StatefulWidget {
  @override
  State<newPass> createState() => _newPassState();
}

class _newPassState extends State<newPass> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: 30, left: 15, right: 15),
      child: SingleChildScrollView(child: screen < 750 ? small() : big()),
    ));
  }
}

class small extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 120;
    y = 136;
    return Column(
      children: [
        title("تغيير كلمة السر", "images/unlocked.png",
            " استخدم كلمة سر سهلة ولا يمكن لغيرك ان يعرفها", "", 35),
        SizedBox(
          height: 20,
        ),
        icon(),
        SizedBox(
          height: 20,
        ),
        enter(),
        SizedBox(
          height: 60,
        ),
        toSignin()
      ],
    );
  }
}

class big extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 200;
    y = 250;
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        children: [
          Row(children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 450, minWidth: 100),
              child: Column(
                children: [
                  title(
                      "تغيير كلمة السر",
                      "images/unlocked.png",
                      "حاول استخدام كلمة سر سهلة ولا يمكن لغيرك ان يعرفها",
                      "",
                      35),
                  SizedBox(
                    height: 60,
                  ),
                  enter(),
                  SizedBox(
                    height: 60,
                  ),
                  toSignin()
                ],
              ),
            ),
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 200, minWidth: 100),
                child: icon())
          ]),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}

Widget icon() {
  return Container(
    width: x,
    height: y,
    child: Image.asset("images/padlock.png"),
  );
}

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

class toSignin extends StatefulWidget {
  @override
  State<toSignin> createState() => _noEmailState();
}

class _noEmailState extends State<toSignin> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("لدي حساب بالفعل"),
        InkWell(
          child: Text(
            "تسجيل الدخول",
            style: TextStyle(color: Colors.green),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Signin();
            }));
          },
        ),
      ],
    );
  }
}
