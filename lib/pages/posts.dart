import 'package:Quran/appBar.dart';
import 'package:flutter/material.dart';

int likes = 0, comments = 0;
bool like = false;
Icon love = Icon(Icons.favorite_border_sharp);

String comment = "التعليق على المنشور";
var images = [
  "images/image1.jpg",
  "images/image2.jpg",
  "images/image3.jpg",
  "images/image4.jpg",
  "images/image5.jpg"
];

var notifications = [
  {
    'احمد',
    ["like", "images/face.jpg"]
  },
  {
    'محمد',
    ["comment", "images/face.jpg"]
  },
  {
    'يعقوب',
    ["post", "images/face.jpg"]
  },
  {
    'رائد',
    ["like", "images/face.jpg"]
  },
  {
    'محمد',
    ["post", "images/face.jpg"]
  },
];

class posts extends StatefulWidget {
  @override
  State<posts> createState() => _postsState();
}

class _postsState extends State<posts> {
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar("صفحة المنشورات"),
      body: Container(
          alignment: Alignment.center,
          color: Colors.black12,
          child: Container(width: 700, child: posts_body())),
    );
  }
}

class posts_body extends StatefulWidget {
  @override
  State<posts_body> createState() => _posts_bodyState();
}

class _posts_bodyState extends State<posts_body> {
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
            post_title(),
            SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.centerRight, child: Text("$comment")),
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
            num_likes_comments(),
            SizedBox(
              height: 20,
            ),
            like_comment()
          ]),
        );
      },
    );
  }
}

class post_title extends StatefulWidget {
  @override
  State<post_title> createState() => _post_titleState();
}

class _post_titleState extends State<post_title> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(children: [
        ClipOval(
            child: Image.asset(
          "images/face.jpg",
          color: Colors.white.withOpacity(1),
          colorBlendMode: BlendMode.modulate,
          height: 45.0,
          width: 48.0,
          fit: BoxFit.fill,
        )),
        Column(
          children: [
            Text(
              "محمد مسعود",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "9/2/2023",
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
      ]),
    );
  }
}

class num_likes_comments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
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
            Text("$likes"),
          ]),
          Row(children: [
            Icon(Icons.mode_comment_outlined),
            Text("$comments"),
          ]),
        ],
      ),
    );
  }
}

class like_comment extends StatefulWidget {
  State<like_comment> createState() => _like_commentState();
}

class _like_commentState extends State<like_comment> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
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
                likes++;
                if (!like)
                  love = Icon(
                    Icons.favorite,
                    color: Colors.red,
                  );
                else
                  love = Icon(Icons.favorite_border_sharp);

                like = !like;
              });
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
              setState(() {
                comments++;
              });
            },
          ),
        ],
      ),
    );
  }
}
