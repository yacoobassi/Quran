import 'package:flutter/material.dart';

Icon love = Icon(null);
bool like = false;

class like_comment extends StatefulWidget {
  Function refresh, inclikes, showComments;

  like_comment({Key myKey, this.refresh, this.inclikes, this.showComments})
      : super(key: myKey);

  State<like_comment> createState() => _like_commentState();
}

class _like_commentState extends State<like_comment> {
  @override
  void initState() {
    super.initState();
    love = Icon(Icons.favorite_border_sharp);
    like = false;
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Row(
              children: [
                love,
                Text(
                  "أعجبني",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                like = !like;
                love = like
                    ? Icon(
                        Icons.favorite_outlined,
                        color: Colors.red,
                      )
                    : Icon(Icons.favorite_border_rounded);
              });
              widget.inclikes;
              widget.refresh;
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
              widget.showComments();
            },
          ),
        ],
      ),
    );
  }
}
