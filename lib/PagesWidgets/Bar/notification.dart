import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/Chat/screens/chat_screen.dart';
import 'package:test_ro_run/sharedPref.dart';

import '../../Chat/models/user_model.dart';

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
            FutureBuilder(
                future: Pref.getNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var notifications = snapshot.data;

                    return Container(
                      margin: EdgeInsets.only(top: 60),
                      child: ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (BuildContext context, int index) {
                          var userModelJson = notifications[index]['userModel'];
                          UserModel userModel = new UserModel(
                              date: userModelJson['date'],
                              email: userModelJson['email'],
                              image: userModelJson['image'],
                              name: userModelJson['name'],
                              token: userModelJson['tokem'],
                              uid: userModelJson['uid']);
                          DateTime jsonMap =
                              DateTime.parse(notifications[index]['date']);

                          return InkWell(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: NetworkImage(
                                        notifications[index]['image']),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "قام ${notifications[index]['name']} ${widget.text}",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        formatDateTime(jsonMap),
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ChatScreen(
                                    currentUser: new UserModel(
                                        email: userModel.email,
                                        name: userModel.name,
                                        image: userModel.image,
                                        date: userModel.date,
                                        uid: userModel.uid,
                                        token: userModel.token),
                                    friendId: notifications[index]['id'],
                                    friendName: notifications[index]['name'],
                                    friendImage: notifications[index]['image']);
                              }));
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return Text("");
                  }
                }),
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
