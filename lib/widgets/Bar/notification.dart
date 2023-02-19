import 'package:flutter/material.dart';

var notifications = [
  {'name': 'احمد', 'image': "images/face.jpg"},
  {'name': 'يعقوب', 'image': "images/face.jpg"},
  {'name': 'محمد', 'image': "images/face.jpg"},
  {'name': 'رائد', 'image': "images/face.jpg"},
  {'name': 'احمد', 'image': "images/face.jpg"},
  {'name': 'يعقوب', 'image': "images/face.jpg"},
  {'name': 'محمد', 'image': "images/face.jpg"},
  {'name': 'رائد', 'image': "images/face.jpg"},
  {'name': 'يعقوب', 'image': "images/face.jpg"},
  {'name': 'محمد', 'image': "images/face.jpg"},
  {'name': 'رائد', 'image': "images/face.jpg"},
  {'name': 'احمد', 'image': "images/face.jpg"},
  {'name': 'يعقوب', 'image': "images/face.jpg"},
  {'name': 'احمد', 'image': "images/face.jpg"},
  {'name': 'يعقوب', 'image': "images/face.jpg"},
  {'name': 'محمد', 'image': "images/face.jpg"},
  {'name': 'رائد', 'image': "images/face.jpg"},
  {'name': 'احمد', 'image': "images/face.jpg"},
  {'name': 'يعقوب', 'image': "images/face.jpg"},
  {'name': 'محمد', 'image': "images/face.jpg"},
  {'name': 'رائد', 'image': "images/face.jpg"},
  {'name': 'يعقوب', 'image': "images/face.jpg"},
  {'name': 'محمد', 'image': "images/face.jpg"},
  {'name': 'رائد', 'image': "images/face.jpg"},
  {'name': 'احمد', 'image': "images/face.jpg"},
  {'name': 'يعقوب', 'image': "images/face.jpg"},
];

class notification extends StatefulWidget {
  double width;
  notification({Key myKey, this.width}) : super(key: myKey);

  @override
  State<notification> createState() => _notification_State();
}

class _notification_State extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: widget.width < 600 ? double.infinity : 300,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(top: 0, left: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 0),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
          ),
          child: ListView.builder(
            itemCount: notifications.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return index == 0
                  ? Container(
                      child: Text(
                        "الاشعارات",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    )
                  : InkWell(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipOval(
                                child: Image.asset(
                              notifications[index - 1]['image'],
                              color: Colors.white.withOpacity(1),
                              colorBlendMode: BlendMode.modulate,
                              height: 60.0,
                              width: 60.0,
                              fit: BoxFit.fill,
                            )),
                            Column(
                              children: [
                                Text(
                                  "قام ${notifications[index - 1]['name']} باضافة",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "منذ 5 دقائق",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
            },
          )),
    );
  }
}
