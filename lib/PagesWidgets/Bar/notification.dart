import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/Chat/screens/chat_screen.dart';

import '../../Chat/models/user_model.dart';
import '../../User/Data.dart';

class notification extends StatefulWidget {
  double width;
  String text;

  notification({Key myKey, this.width, this.text}) : super(key: myKey);

  @override
  State<notification> createState() => _notification_State();
}

class _notification_State extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      width: widget.width < 600 ? double.infinity : 300,
      child: Container(
        padding: EdgeInsets.only(
          right: 10,
        ),
        margin: EdgeInsets.only(bottom: widget.width < 600 ? 0 : 30, left: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(widget.width < 600 ? 0 : 15),
              bottomRight: Radius.circular(widget.width < 600 ? 0 : 15),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ))),
                child: Text(
                  "الاشعارات",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('notifications')
                  .doc(Data.user.email)
                  .collection("messages")
                  .orderBy("time", descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length < 1) {
                    return Center(
                      child: Text("No Chats Available !"),
                    );
                  }

                  return Container(
                    margin: EdgeInsets.only(top: 60),
                    child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        Timestamp date = snapshot.data.docs[index]['time'];
                        var id = snapshot.data.docs[index]['senderId'];
                        return FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(id)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data;

                                String name = data['name'];
                                String image = data['image'];

                                return InkWell(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20.0,
                                          backgroundImage: NetworkImage(image),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "قام ${name} ${widget.text}",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                              formatDateTime(date.toDate()),
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    var userModel = await FirebaseFirestore
                                        .instance
                                        .collection('users')
                                        .doc(Data.user.email)
                                        .get();

                                    String username = userModel['name'];
                                    String userdate =
                                        userModel['date'].toString();
                                    String usertoken = userModel['token'];
                                    String useremail = userModel['email'];
                                    String userimage = userModel['image'];
                                    String userid = userModel['uid'];
                                    Navigator.pop(context);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      UserModel usermodel = new UserModel(
                                          date: userdate,
                                          email: useremail,
                                          image: userimage,
                                          name: username,
                                          token: usertoken,
                                          uid: userid);
                                      return ChatScreen(
                                        currentUser: usermodel,
                                        friendName: name,
                                        friendImage: image,
                                        friendId: id,
                                      );
                                    }));
                                  },
                                );
                              } else {
                                return Text("");
                              }
                            });
                      },
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
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
    return 'قبل ${diff.inSeconds} ثواني';
  } else if (diff.inMinutes < 60) {
    return 'قبل ${diff.inMinutes} دقائق';
  } else if (diff.inHours < 24) {
    return 'قبل ${diff.inHours} ساعات';
  } else if (diff.inDays < 30) {
    return 'قبل ${diff.inDays} أيام';
  } else if (diff.inDays < 365) {
    return "قبل ${DateFormat.MMMM().format(dateTime)} شهر";
  } else {
    return "قبل ${DateFormat.y().format(dateTime)} سنين";
  }
}
