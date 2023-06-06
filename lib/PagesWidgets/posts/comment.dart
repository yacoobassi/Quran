import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Links.dart';
import '../../User/Data.dart';
import '../../request.dart';

double comments_width = 0.0, circular = 0.0, screenwidth = 0.0;

class comments_container extends StatefulWidget {
  Function closeComments;
  final width;
  int post;
  comments_container({Key myKey, this.width, this.closeComments, this.post})
      : super(key: myKey);

  @override
  State<comments_container> createState() => _comments_containerState();
}

class _comments_containerState extends State<comments_container> {
  ScrollController _controller;
  Requst request = new Requst();
  final TextEditingController _comment = new TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
  }

  getComment() async {
    var response = await request.postRequest(getComments, {
      "post": widget.post.toString(),
    });

    return response;
  }

  addcomment() async {
    var response = await request.postRequest(addComment, {
      "post": widget.post.toString(),
      "num": Data.user.email.replaceAll("@gmail.com", ""),
      "comment": _comment.text,
      "date": DateTime.now().toString(),
      "image": Data.user.image
    });

    return response;
  }

  incComments() async {
    var response = await request.postRequest(LinkincComments, {
      "count": widget.post.toString(),
    });
    return response;
  }

  Widget build(BuildContext context) {
    bool isDesktop = widget.width >= 900;
    DateTime dateTime;
    Timestamp timestamp;
    double screenwidth = isDesktop ? widget.width - 200 : double.infinity;
    double comments_width = isDesktop ? 800 : double.infinity;
    double circular = isDesktop ? 20 : 0;

    // This is what you're looking for!
    Future<void> _scrollDown() async {
      await Future.delayed(
        Duration(milliseconds: 100),
        () {
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
        },
      );
    }

    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20),
        width: comments_width,
        height: comments_width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(circular),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.closeComments();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: getComment(),
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Container(
                    margin: EdgeInsets.only(top: 50, bottom: 70),
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (BuildContext context, int index) {
                        dateTime = DateTime.parse(
                            snapshot.data['data'][index]['date']);
                        timestamp = Timestamp.fromMillisecondsSinceEpoch(
                            dateTime.millisecondsSinceEpoch);
                        return Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: ClipOval(
                                  child: CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                    snapshot.data['data'][index]['image']),
                                backgroundColor: Colors.transparent,
                              )),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(31, 116, 114, 114),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data['data'][index]['name'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: 100,
                                          maxWidth: screenwidth - 150,
                                        ),
                                        child: Text(
                                          snapshot.data['data'][index]
                                              ['comment'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  formatDateTime(timestamp.toDate()),
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  );
                else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(31, 116, 114, 114),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: _comment,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "اضف تعليقا",
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_comment.text.isNotEmpty) {
                          incComments();

                          setState(() {
                            addcomment();

                            _comment.clear();
                            _scrollDown();
                          });
                        }
                      },
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final diff = now.difference(dateTime);

  if (diff.inSeconds < 60) {
    return 'الان';
  } else if (diff.inMinutes < 60) {
    return 'قبل ${diff.inMinutes} دقيقة';
  } else if (diff.inHours < 24) {
    return 'قبل ${diff.inHours} ساعة';
  } else
    return "${dateTime.year}/${dateTime.month}/${dateTime.day}";
}
