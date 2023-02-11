import 'package:flutter/material.dart';

Widget title(
    String title, String image, String text, String image2, double fontSize) {
  return Column(
    children: [
      Row(
        children: [
          Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.only(left: 10),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              )),
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              color: Color.fromARGB(255, 111, 114, 153),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.black54),
          ),
          image2 == ""
              ? Text("")
              : Container(
                  height: 15,
                  width: 15,
                  margin: EdgeInsets.only(right: 5),
                  child: Image.asset(
                    image2,
                    fit: BoxFit.fill,
                  )),
        ],
      )
    ],
  );
}
