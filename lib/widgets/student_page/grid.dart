import 'package:flutter/material.dart';

var data = [
  {
    'icon': Icon(
      Icons.mosque,
      size: 40,
      color: Colors.green,
    ),
    'title': "المركز",
    'answer': "المركز2"
  },
  {
    'icon': Icon(
      Icons.done_outline_rounded,
      size: 40,
      color: Colors.green,
    ),
    'title': "عدد الأجزاء المنجزة ",
    'answer': "5 أجزاء"
  },
  {
    'icon': Icon(
      Icons.timelapse_sharp,
      size: 40,
      color: Colors.green,
    ),
    'title': "الجزء الحالي",
    'answer': "جزء 20"
  },
  {
    'icon': Icon(
      Icons.font_download_outlined,
      size: 40,
      color: Colors.green,
    ),
    'title': "المعدل التراكمي",
    'answer': "100/95"
  },
  {
    'icon': Icon(
      Icons.pending_actions_outlined,
      size: 40,
      color: Colors.green,
    ),
    'title': "علامة الامتحان السابق",
    'answer': "10/9"
  },
  {
    'icon': Icon(
      Icons.calendar_month,
      size: 40,
      color: Colors.green,
    ),
    'title': "موعد الامتحان القادم",
    'answer': "15/3/2023"
  }
];

class grid extends StatelessWidget {
  double width;
  grid({
    Key myKey,
    this.width,
  }) : super(key: myKey);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 240, left: 50, right: 50),
      width: width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  data[index]['icon'],
                  Text(data[index]['title']),
                  Text(
                    data[index]['answer'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ));
        },
      ),
    );
  }
}
