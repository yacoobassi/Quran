import 'package:Quran/widgets/posts/comment.dart';
import 'package:flutter/material.dart';
import '../widgets/Bar/appBar.dart';
import '../widgets/Bar/notification.dart';
import '../widgets/posts/posts_body.dart';

String comment = "التعليق على المنشور";

bool visible, infinity;
int post_message;

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
    post_message = 0;
  }

  show() {
    visible = !visible;
    setState(() {});
  }

  likes() {
    post_message = 1;
  }

  comments() {
    post_message = 2;
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
          likes: likes,
          comments: comments,
          width: false,
        ),
        body: Stack(children: [
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
          Align(
            alignment: Alignment.topLeft,
            child: notification(
                show: visible,
                infinty: infinity,
                message_post: post_message,
                margin: false),
          ),
          Visibility(visible: true, child: comments_container(width: screen))
        ]));
  }
}
