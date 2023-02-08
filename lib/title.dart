import 'package:flutter/material.dart';

Widget title(String title, String image) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 40,
              color: Color.fromARGB(255, 111, 114, 153),
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.only(left: 10),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ))
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              height: 15,
              width: 15,
              margin: EdgeInsets.only(right: 5),
              child: Image.asset(
                "images/love.png",
                fit: BoxFit.fill,
              )),
          Text(
            "سجل الآن",
            style: TextStyle(color: Colors.black54),
          ),
        ],
      )
    ],
  );
}