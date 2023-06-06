import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/Chat/screens/search_screen.dart';
import 'package:test_ro_run/showImage.dart';
import 'package:test_ro_run/image.dart';

import '../models/user_model.dart';

import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  UserModel user;
  HomeScreen(this.user);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final image = ImageHelper();
  var me;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, actions: [
        Center(
          child: Text(
            'الدردشات',
            style: TextStyle(fontSize: 30),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: InkWell(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.user.email)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  me = snapshot.data;
                  return CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(me['image']),
                    backgroundColor: Colors.transparent,
                  );
                } else {
                  return Text("");
                }
              },
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return showImage(me['image'], true);
              }));
            },
          ),
        ),
      ]),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user.uid)
              .collection('messages')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length < 1) {
                return Center(
                  child: Text("No Chats Available !"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var friendId = snapshot.data.docs[index].id;
                    var lastMsg = snapshot.data.docs[index]['last_msg'];
                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(friendId)
                          .get(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          var friend = asyncSnapshot.data;
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(friend['image']),
                              backgroundColor: Colors.transparent,
                            ),
                            title: Text(friend['name']),
                            subtitle: Container(
                              child: Text(
                                "$lastMsg",
                                style: TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                          currentUser: widget.user,
                                          friendId: friend['uid'],
                                          friendName: friend['name'],
                                          friendImage: friend['image'])));
                            },
                          );
                        }
                        return LinearProgressIndicator();
                      },
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchScreen(true, false)));
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.startFloat, // Move FAB to the right side
    );
  }
}
