import 'package:Quran/textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

var comments = [
  {
    'name': 'احمد',
    'image': "images/face.jpg",
    'comment': "التعليق على هذا المنشور"
  },
  {
    'name': 'يعقوب',
    'image': "images/face.jpg",
    'comment': "التعليق على هذا المنشور"
  },
  {
    'name': 'محمد',
    'image': "images/face.jpg",
    'comment': "التعليق على هذا المنشور"
  },
  {
    'name': 'رائد',
    'image': "images/face.jpg",
    'comment': "التعليق على هذا المنشور"
  },
  {
    'name': 'احمد',
    'image': "images/face.jpg",
    'comment': "التعليق على هذا المنشور"
  },
  {
    'name': 'يعقوب',
    'image': "images/face.jpg",
    'comment': "التعليق على هذا المنشور"
  },
];

class comments_container extends StatefulWidget {
  final width;
  comments_container({Key myKey, this.width}) : super(key: myKey);

  @override
  State<comments_container> createState() => _comments_containerState();
}

class _comments_containerState extends State<comments_container> {
  @override
  Widget build(BuildContext context) {
    final screenwidth =
        widget.width < 600 ? double.infinity : widget.width - 200;
    final TextEditingController _comment = new TextEditingController();

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(31, 116, 114, 114),
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
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: widget.width - 150),
                                  child: Text(
                                    comments[index]['comment'],
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                    overflow: TextOverflow.clip,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                              margin:
                                  EdgeInsets.only(right: 15, top: 5, bottom: 5),
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
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                      //                   <--- left side
                      color: Colors.grey,
                      width: 1.0,
                    ))),
                padding: EdgeInsets.all(5),
                width: double.infinity,
                child: TextFormField(
                  controller: _comment,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color.fromARGB(31, 116, 114, 114),
                      hintText: "أكتب تعليق",
                      hintStyle: TextStyle(color: Colors.black38)),
                  onFieldSubmitted: (val) {
                    setState(() {
                      comments.add({
                        'name': "يعقوب",
                        'image': "images/face.jpg",
                        'comment': "$val",
                      });
                    });
                    _comment.clear();
                  },
                ))
          ],
        ),
      ),
    );
  }
}
