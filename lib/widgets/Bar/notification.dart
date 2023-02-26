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
  String text;
  notification({Key myKey, this.width, this.text}) : super(key: myKey);

  @override
  State<notification> createState() => _notification_State();
}

class _notification_State extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      width: widget.width < 600 ? double.infinity : 300,
      child: Container(
        padding: EdgeInsets.only(
          right: 10,
        ),
        margin: EdgeInsets.only(bottom: widget.width < 600 ? 0 : 30, left: 10),
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
              bottomLeft: Radius.circular(widget.width < 600 ? 0 : 15),
              bottomRight: Radius.circular(widget.width < 600 ? 0 : 15),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ))),
                child: Text(
                  "الاشعارات",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipOval(
                              child: Image.asset(
                            notifications[index]['image'],
                            color: Colors.white.withOpacity(1),
                            colorBlendMode: BlendMode.modulate,
                            height: 60.0,
                            width: 60.0,
                            fit: BoxFit.fill,
                          )),
                          Column(
                            children: [
                              Text(
                                "قام ${notifications[index]['name']} ${widget.text}",
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
