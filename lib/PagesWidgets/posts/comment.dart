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
  {
    'name': 'يعقوب',
    'image': "images/face.jpg",
    'comment': "التعليق على هذا المنشور"
  },
  {
    'name': 'يعقوب',
    'image': "images/face.jpg",
    'comment': "التعليق على هذا المنشور"
  },
  {
    'name': 'يعقوب',
    'image': "images/face.jpg",
    'comment': "التعليق على هذا المنشور"
  },
  {
    'name': 'يعقوب',
    'image': "images/face.jpg",
    'comment': "التعليق على هذا المنشور"
  },
];
double comments_width = 0.0, circular = 0.0, screenwidth = 0.0;

class comments_container extends StatefulWidget {
  Function closeComments;
  final width;
  comments_container({Key myKey, this.width, this.closeComments})
      : super(key: myKey);

  @override
  State<comments_container> createState() => _comments_containerState();
}

class _comments_containerState extends State<comments_container> {
  ScrollController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = ScrollController();
  }

  Widget build(BuildContext context) {
    final TextEditingController _comment = new TextEditingController();

    if (widget.width < 900) {
      screenwidth = double.infinity;
      comments_width = double.infinity;
      circular = 0;
    } else {
      screenwidth = widget.width - 200;
      comments_width = 800;
      circular = 20;
    }

// This is what you're looking for!
    Future _scrollDown() async {
      await Future.delayed(Duration(milliseconds: 100), () {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      });
    }

    return Center(
        child: Container(
            width: comments_width,
            height: comments_width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(circular)),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ))),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            widget.closeComments();
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50, bottom: 60),
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _controller,
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
                                margin: EdgeInsets.only(
                                    right: 15, top: 5, bottom: 5),
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
                        color: Colors.grey,
                        width: 1.0,
                      ))),
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: TextFormField(
                    controller: _comment,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      hintText: "أكتب تعليق",
                      filled: true,
                      fillColor: Color.fromARGB(31, 116, 114, 114),
                    ),
                    maxLines: 3,
                    minLines: 1,
                    onEditingComplete: () {
                      setState(() {
                        comments.add({
                          'name': "يعقوب",
                          'image': "images/face.jpg",
                          'comment': "${_comment.text}",
                        });
                      });
                      _comment.clear();
                      _scrollDown();
                    },
                  ))
            ])));
  }
}
