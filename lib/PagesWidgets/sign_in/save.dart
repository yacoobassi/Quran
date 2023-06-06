import 'package:flutter/material.dart';
import 'package:test_ro_run/pages/new_pass.dart';

bool saveUser = false;

class save extends StatefulWidget {
  @override
  State<save> createState() => _saveState();
}

class _saveState extends State<save> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Expanded(
          //   child: CheckboxListTile(
          //       controlAffinity: ListTileControlAffinity.leading,
          //       title: Text("احفظ تسجيلي"),
          //       value: saveUser,
          //       onChanged: (value) => {
          //             setState(() {
          //               saveUser = value;
          //             })
          //           }),
          // ),
          InkWell(
            child: Text(
              "نسيت كلمة المرور",
              style: TextStyle(color: Colors.green),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => newPass(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
