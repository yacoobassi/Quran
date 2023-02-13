import 'package:flutter/material.dart';
import '../widgets/Bar/appBar.dart';
import '../widgets/Bar/notification.dart';
import '../widgets/posts/posts_body.dart';

String comment = "التعليق على المنشور";

bool visible, infinity;

class posts extends StatefulWidget {
  @override
  State<posts> createState() => _postsState();
}

class _postsState extends State<posts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = false;
  }

  show() {
    visible = !visible;

    setState(() {});
  }

  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;

    if (screen < 600)
      infinity = true;
    else
      infinity = false;

    return Scaffold(
        appBar: appbar(
          title: "صفحة المنشورات",
          show: show,
        ),
        body: Stack(alignment: Alignment.topLeft, children: [
          GestureDetector(
            onTap: () {
              setState(() {
                visible = false;
              });
            },
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                color: Colors.black12,
                child: Container(width: 700, child: posts_body())),
          ),
          notification(show: visible, infinty: infinity)
        ]));
  }
}
