import 'package:Quran/new_pass.dart';
import 'package:Quran/sign_up.dart';
import 'package:flutter/material.dart';
import 'title.dart';

Icon eye = Icon(Icons.remove_red_eye_outlined);
bool presed = false;
bool saveUser = false;
double x, y;

class Signin extends StatefulWidget {
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: null,
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30, right: 20, left: 20),
        child: SingleChildScrollView(child: screen < 600 ? small() : big()),
      ),
    );
  }
}

class small extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 120;
    y = 136;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title("تسجيل الدخول", "images/handshake.png",
            "نحن في انتظارك في اقرأ سجل الان", "images/love.png"),
        icon(),
        enter(),
        links(),
        SizedBox(
          height: 30,
        ),
        toSignUp()
      ],
    );
  }
}

class big extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    x = 300;
    y = 330;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(children: [
          Expanded(
            child: Column(
              children: [
                title("تسجيل الدخول", "images/handshake.png",
                    "نحن في انتظارك في اقرأ سجل الان", "images/love.png"),
                SizedBox(
                  height: 60,
                ),
                enter()
              ],
            ),
          ),
          Expanded(child: icon())
        ]),
        SizedBox(
          height: 60,
        ),
        links()
      ],
    );
  }
}

Widget icon() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    child: Image.asset(
      "images/logo.png",
      width: x,
      height: y,
    ),
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
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              hintText: "البريد الالكتروني",
              suffixIcon: Icon(Icons.email),
              filled: true,
              fillColor: Colors.grey[280],
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300])),
            ),
          )),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 50,
          child: Form(
            child: TextFormField(
              obscureText: !presed,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                hintText: "كلمة السر",
                suffixIcon: Icon(Icons.key),
                prefixIcon: IconButton(
                  icon: eye,
                  onPressed: () {
                    setState(() {
                      if (!presed)
                        eye = Icon(Icons.remove_red_eye_rounded);
                      else
                        eye = Icon(Icons.remove_red_eye_outlined);

                      presed = !presed;
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
              onPressed: () {},
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
}

class save extends StatefulWidget {
  @override
  State<save> createState() => _saveState();
}

class _saveState extends State<save> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: Text(
            "نسيت كلمة المرور",
            style: TextStyle(color: Colors.green),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return newPass();
            }));
          },
        ),
        Row(
          children: [
            Text("احفظ تسجيلي"),
            Checkbox(
                value: saveUser,
                onChanged: (value) => {
                      setState(() {
                        saveUser = value;
                      })
                    })
          ],
        )
      ],
    );
  }
}

class links extends StatefulWidget {
  @override
  State<links> createState() => _linksState();
}

class _linksState extends State<links> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("سجل دخولك باستخدام "),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                onPressed: () {},
                child: Icon(
                  Icons.facebook,
                  color: Colors.blue,
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[300]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                  ),
                  onPressed: () {},
                  child: Image.asset(
                    "images/google.png",
                  )),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                onPressed: () {},
                child: Icon(
                  Icons.apple,
                  color: Colors.black,
                ))
          ],
        )
      ],
    );
  }
}

class toSignUp extends StatefulWidget {
  @override
  State<toSignUp> createState() => _noEmailState();
}

class _noEmailState extends State<toSignUp> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Text(
            "انشاء حساب جديد",
            style: TextStyle(color: Colors.green),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return signUp();
            }));
          },
        ),
        Text("ليس لدي حساب"),
      ],
    );
  }
}
