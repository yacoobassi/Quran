import 'package:flutter/material.dart';

import '../../FiledIconButton.dart';
import '../../textfiled.dart';

class enter extends StatefulWidget {
  @override
  State<enter> createState() => _enterState();
}

Icon posticon1, posticon2;

class _enterState extends State<enter> {
  bool visible1 = false;
  bool visible2 = false;
  swapIcon1() {
    posticon1 = visible1
        ? Icon(Icons.remove_red_eye_outlined)
        : Icon(Icons.remove_red_eye_rounded);

    visible1 = !visible1;
    setState(() {});
  }

  swapIcon2() {
    posticon2 = visible2
        ? Icon(Icons.remove_red_eye_outlined)
        : Icon(Icons.remove_red_eye_rounded);

    visible2 = !visible2;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    posticon1 = Icon(Icons.remove_red_eye_outlined);
    posticon2 = Icon(Icons.remove_red_eye_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          obscureText: !visible1,
          decoration: filedDecoration("كلمة السر الجديدة", Icon(Icons.key), 1),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          obscureText: !visible2,
          decoration: filedDecoration("اعادة كلمة السر", Icon(Icons.key), 2),
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

  InputDecoration filedDecoration(String text, Icon preIcon, int filed) {
    return InputDecoration(
      hintText: "$text",
      prefixIcon: preIcon,
      suffixIcon: filed == 1
          ? FiledIconButton(icon: posticon1, swapicon: swapIcon1)
          : FiledIconButton(icon: posticon2, swapicon: swapIcon2),
      filled: true,
      fillColor: Colors.grey[280],
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300])),
    );
  }
}
