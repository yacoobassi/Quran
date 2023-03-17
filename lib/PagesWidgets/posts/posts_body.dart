import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/posts/post_publisher.dart';
import 'like_comment.dart';
import 'like_comment_num.dart';

var images = [
  "images/image1.jpg",
  "images/image2.jpg",
  "images/image3.jpg",
  "images/image4.jpg",
  "images/image5.jpg"
];
int likes = 0, comments = 0;

class posts_body extends StatefulWidget {
  Function showComments;
  posts_body({
    Key myKey,
    this.showComments,
  }) : super(key: myKey);
  @override
  State<posts_body> createState() => _posts_bodyState();
}

class _posts_bodyState extends State<posts_body> {
  incLikes() {
    likes++;
  }

  incComments() {
    comments++;
  }

  bool like(bool value) {
    return !value;
  }

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    likes = 0;
    comments = 0;
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          margin: EdgeInsets.symmetric(vertical: 30),
          child: Column(children: [
            post_publisher(),
            SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(10),
                child: Text("التعليق على المنشور")),
            Container(
              width: double.infinity,
              child: Image.asset(
                images[index],
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            num_likes_comments(
              likes: likes,
              comments: comments,
            ),
            SizedBox(
              height: 20,
            ),
            like_comment(
              refresh: refresh,
              inclikes: incLikes,
              showComments: widget.showComments,
            )
          ]),
        );
      },
    );
  }
}
