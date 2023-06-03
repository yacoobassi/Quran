import 'package:flutter/material.dart';

class num_likes_comments extends StatefulWidget {
  int likes, comments;
  num_likes_comments({Key myKey, this.likes, this.comments})
      : super(key: myKey);

  @override
  State<num_likes_comments> createState() => _num_likes_commentsState();
}

class _num_likes_commentsState extends State<num_likes_comments> {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey,
        width: 1.0,
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            Text("${widget.likes}"),
          ]),
          Row(children: [
            Icon(Icons.mode_comment_outlined),
            Text("${widget.comments}"),
          ]),
        ],
      ),
    );
  }
}
