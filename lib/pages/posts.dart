import 'package:flutter/material.dart';

import '../PagesWidgets/Bar/appBar.dart';
import '../PagesWidgets/Bar/notification.dart';
import '../PagesWidgets/posts/comment.dart';
import '../PagesWidgets/posts/posts_body.dart';

String comment = "التعليق على المنشور", likeORcomment = "";

int post_message;
double opacity;

class posts extends StatefulWidget {
  @override
  State<posts> createState() => _postsState();
}

class _postsState extends State<posts> {
  GlobalKey<ScaffoldState> globalkey = new GlobalKey<ScaffoldState>();
  bool visible, infinity, commentsVisible;
  int Post;
  showComments(int post) {
    commentsVisible = true;
    Post = post;
    opacity = 0.4;

    setState(() {});
  }

  closeComments() {
    commentsVisible = false;
    opacity = 1;
    setState(() {});
  }

  show(String text) {
    globalkey.currentState.openEndDrawer();
    likeORcomment = text;
    setState(() {});
  }

  likes() {
    post_message = 1;
  }

  comments() {
    post_message = 2;
  }

  void initState() {
    super.initState();
    visible = false;
    post_message = 0;
    opacity = 1;
    commentsVisible = false;
  }

  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;

    if (screen < 600)
      infinity = true;
    else
      infinity = false;

    return Scaffold(
        key: globalkey,
        appBar: commentsVisible
            ? null
            : appbar(
                title: "صفحة المنشورات",
                show: show,
                likes: likes,
                comments: comments,
                width: false,
                opacity: opacity,
              ),
        body: WillPopScope(
          onWillPop: () async {
            if (commentsVisible) {
              closeComments();
              return false;
            }
            return true;
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: Colors.black12,
                  child: Container(
                      width: 700,
                      child: posts_body(
                        showComments: showComments,
                      ))),
              Visibility(
                  visible: commentsVisible,
                  child: comments_container(
                      width: screen, closeComments: closeComments, post: Post)),
            ],
          ),
        ));
  }
}
