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
  bool show, infinty;

  notification({Key myKey, this.show, this.infinty}) : super(key: myKey);

  @override
  State<notification> createState() => _notification_State();
}

class _notification_State extends State<notification> {
  @override
  Widget build(BuildContext context) {
    double circular = widget.infinty ? 0 : 15;
    double margin = widget.infinty ? 0 : 10;
    double width = widget.infinty ? double.infinity : 300;
    return Visibility(
      visible: widget.show,
      child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: margin, bottom: margin),
          width: width,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(circular))),
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
                                  "قام ${notifications[index - 1]['name']} باضافة منشور ",
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
