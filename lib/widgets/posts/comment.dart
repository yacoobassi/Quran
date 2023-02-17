import 'package:Quran/textfiled.dart';
import 'package:flutter/material.dart';

var comments = [
  {'name': 'احمد', 'image': "images/face.jpg"},
  {'name': 'يعقوب', 'image': "images/face.jpg"},
  {'name': 'محمد', 'image': "images/face.jpg"},
  {'name': 'رائد', 'image': "images/face.jpg"},
  {'name': 'احمد', 'image': "images/face.jpg"},
  {'name': 'يعقوب', 'image': "images/face.jpg"},
];

class comments_container extends StatelessWidget {
  final width;
  comments_container({Key myKey, this.width}) : super(key: myKey);
  @override
  Widget build(BuildContext context) {
    final screenwidth = width < 600 ? double.infinity : width - 200;
    return Center(
      child: Container(
        width: 600,
        height: 800,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      ClipOval(
                          child: Image.asset(
                        "images/face.jpg",
                        colorBlendMode: BlendMode.modulate,
                        height: 60.0,
                        width: 60.0,
                        fit: BoxFit.fill,
                      )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comments[index]['name'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "التعل5555555555555555555555555555555555555555555555555555555555يق على هذا المنشور",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Text(
                                "5 س",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ))
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                      //                   <--- left side
                      color: Colors.grey,
                      width: 1.0,
                    ))),
                padding: EdgeInsets.all(5),
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.black12,
                      hintText: "أكتب تعليق",
                      hintStyle: TextStyle(color: Colors.black54)),
                ))
          ],
        ),
      ),
    );
  }
}
