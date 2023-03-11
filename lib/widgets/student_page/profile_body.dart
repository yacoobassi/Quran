import 'package:flutter/material.dart';

class profile_body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "الاسم : يعقوب عادل عاصي",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "المركز : 16",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "5 : عدد الاجزاء التي اتمها الطالب",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            "الجزء الحالي : جزء عم",
            style: TextStyle(fontSize: 15),
          ),
          Text(
            "علامة الامتحان السابق : 90",
            style: TextStyle(fontSize: 15),
          ),
          Text(
            "المعدل التركمي : 90",
            style: TextStyle(fontSize: 15),
          ),
        ])
      ],
    );
  }
}
