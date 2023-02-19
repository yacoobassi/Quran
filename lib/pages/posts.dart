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
  GlobalKey<ScaffoldState> globalkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = false;
    post_message = 0;
  }

  show() {
    globalkey.currentState.openEndDrawer();
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
        key: globalkey,
        appBar: appbar(
          title: "صفحة المنشورات",
          show: show,
          likes: likes,
          comments: comments,
          width: false,
        ),
        endDrawer: notification(width: screen),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                color: Colors.black12,
                child: Container(width: 700, child: posts_body())),
            Visibility(visible: true, child: comments_container(width: screen))
          ],
        ));
  }
}
