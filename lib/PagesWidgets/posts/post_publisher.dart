import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../User/Data.dart';
import '../../showImage.dart';

class post_publisher extends StatefulWidget {
  @override
  State<post_publisher> createState() => _post_titleState();
  post_publisher(this.name, this.date);
  String name;
  String date;
}

class _post_titleState extends State<post_publisher> {
  DateTime dateTime;
  Timestamp timestamp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime = DateTime.parse(widget.date);
    timestamp =
        Timestamp.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(children: [
        ClipOval(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(Data.user.email)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return InkWell(
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(snapshot.data['image']),
                    backgroundColor: Colors.transparent,
                  ),
                  onTap: () {
                    return Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return showImage(snapshot.data['image'], true);
                    }));
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        Column(
          children: [
            Text(
              widget.name,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              formatDateTime(timestamp.toDate()),
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
      ]),
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
