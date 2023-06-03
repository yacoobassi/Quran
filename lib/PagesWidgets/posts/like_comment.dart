import 'package:flutter/material.dart';

import '../../Links.dart';
import '../../User/Data.dart';
import '../../request.dart';

class like_comment extends StatefulWidget {
  Function refresh, showComments;
  int count, likes, comment, index;
  String date;
  int like;

  like_comment(this.likes, this.comment, this.count, this.refresh,
      this.showComments, this.like);

  State<like_comment> createState() => _like_commentState();
}

class _like_commentState extends State<like_comment> {
  Icon love;
  @override
  void initState() {
    super.initState();
    love = widget.like == 1
        ? Icon(
            Icons.favorite,
            color: Colors.red,
          )
        : Icon(Icons.favorite_border_sharp);

    print(true);
  }

  Requst request = new Requst();
  int likes = 0;

  incLikes() async {
    var response = await request.postRequest(LinkincLikes, {
      "count": widget.count.toString(),
    });
    return response;
  }

  disLike() async {
    var response = await request.postRequest(LinkdisLike, {
      "count": widget.count.toString(),
    });

    return response;
  }

  addLike() async {
    var postNum = widget.count
        .toString(); // make sure you're sending the correct value for postNum
    var response = await request.postRequest(LinkaddLike, {
      "num": Data.user.email.replaceAll("@gmail.com", ""),
      "postNum": postNum // use the variable postNum instead of widget.count
    });

    return response;
  }

  removelikes() async {
    var postNum = widget.count
        .toString(); // make sure you're sending the correct value for postNum
    var response = await request.postRequest(removeLike, {
      "num": Data.user.email.replaceAll("@gmail.com", ""),
      "postNum": postNum // use the variable postNum instead of widget.count
    });

    return response;
  }

  Widget build(BuildContext context) {
    return Column(children: [
      Container(
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
              Text("${widget.comment}"),
            ]),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                child: Row(
                  children: [
                    love,
                    Text(
                      "أعجبني",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                if (widget.like == 1) {
                  widget.like = 0;

                  widget.likes--;

                  love = Icon(Icons.favorite_border_sharp);
                  disLike();
                  removelikes();
                } else if (widget.like == 0) {
                  widget.like = 1;

                  widget.likes++;
                  love = Icon(
                    Icons.favorite,
                    color: Colors.red,
                  );
                  await incLikes();
                  addLike();
                }
                widget.refresh();
              },
            ),
            SizedBox(
              width: 40,
            ),
            InkWell(
              child: Row(children: [
                Icon(Icons.mode_comment_outlined),
                Text(
                  "تعليق",
                  style: TextStyle(fontSize: 20),
                ),
              ]),
              onTap: () {
                widget.showComments(widget.count);
              },
            ),
          ],
        ),
      ),
    ]);
  }
}
