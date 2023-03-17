import 'package:flutter/material.dart';

bool saveUser = false;

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
        Expanded(
          child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text("احفظ تسجيلي"),
              value: saveUser,
              onChanged: (value) => {
                    setState(() {
                      saveUser = value;
                    })
                  }),
        ),
        InkWell(
          child: Text(
            "نسيت كلمة المرور",
            style: TextStyle(color: Colors.green),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
