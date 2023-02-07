import 'package:Quran/sign_in.dart';
import 'package:Quran/title.dart';
import 'package:flutter/material.dart';

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
    if (screen > 700) {
      x = 180;
      y = 210;
    } else if (screen > 500) {
      x = 160;
      y = 180;
    } else {
      x = 120;
      y = 136;
    }

    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    title(
                        "تغيير كلمة السر",
                        "images/unlocked.png",
                        "حاول استخدام كلمة سر سهلة ولا يمكن لغيرك ان يعرفها",
                        ""),
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
                  ]),
            ),
          )),
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
        SizedBox(
          height: 50,
          child: Form(
            child: TextFormField(
              obscureText: !presed1,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                hintText: "كلمة السر الجديدة",
                suffixIcon: Icon(Icons.key),
                prefixIcon: IconButton(
                  icon: eye1,
                  onPressed: () {
                    setState(() {
                      if (!presed1)
                        eye1 = Icon(Icons.remove_red_eye_rounded);
                      else
                        eye1 = Icon(Icons.remove_red_eye_outlined);

                      presed1 = !presed1;
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.grey[280],
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
          child: Form(
            child: TextFormField(
              obscureText: !presed2,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                hintText: "اعادة كلمة السر",
                suffixIcon: Icon(Icons.key),
                prefixIcon: IconButton(
                  icon: eye2,
                  onPressed: () {
                    setState(() {
                      if (!presed2)
                        eye2 = Icon(Icons.remove_red_eye_rounded);
                      else
                        eye2 = Icon(Icons.remove_red_eye_outlined);

                      presed2 = !presed2;
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.grey[280],
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
            ),
          ),
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
        Text("لدي حساب بالفعل"),
      ],
    );
  }
}
