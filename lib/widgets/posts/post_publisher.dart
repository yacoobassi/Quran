import 'package:flutter/material.dart';

class post_publisher extends StatefulWidget {
  @override
  State<post_publisher> createState() => _post_titleState();
}

class _post_titleState extends State<post_publisher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(children: [
        ClipOval(
            child: Image.asset(
          "images/face.jpg",
          color: Colors.white.withOpacity(1),
          colorBlendMode: BlendMode.modulate,
          height: 45.0,
          width: 48.0,
          fit: BoxFit.fill,
        )),
        Column(
          children: [
            Text(
              "محمد مسعود",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "9/2/2023",
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
      ]),
    );
  }
}
