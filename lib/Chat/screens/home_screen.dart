import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:test_ro_run/Chat/screens/search_screen.dart';
import 'package:test_ro_run/image.dart';
import 'package:image_cropper/image_cropper.dart';

import '../models/user_model.dart';
import 'package:test_ro_run/sharedPref.dart';

import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  UserModel user;
  HomeScreen(this.user);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File _image;
  final image = ImageHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title:
          // centerTitle: true,
          backgroundColor: Colors.teal,
          actions: [
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
                onTap: () async {
                  final files = await image.pickImage();

                  if (files.isNotEmpty) {
                    final cropfiles = await image.crop(
                        file: files.first, cropStyle: CropStyle.circle);
                    if (cropfiles != null) {
                      setState(() => _image = File(
                            cropfiles.path,
                          ));
                    }

                    UpdateUserImage(
                      cropfiles.path,
                    );
                  }
                },
                child: _image != null
                    ? CircleAvatar(
                        radius: 25,
                        foregroundImage: FileImage(_image),
                        child: Text(""),
                      )
                    : FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.user.email)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var me = snapshot.data;
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
                  builder: (context) => SearchScreen(widget.user)));
        },
      ),
    );
  }

  UpdateUserImage(String path) async {
    try {
      final _auth = await FirebaseAuth.instance;

      final user = await _auth.currentUser;
      final storageReference =
          FirebaseStorage.instance.ref().child("images/" + widget.user.uid);

      await storageReference.putFile(File(path));
      String imageUrl = await storageReference.getDownloadURL();
      Pref.setProfileImage(
        imageUrl,
      );
      var collection = await FirebaseFirestore.instance.collection('users');

      await collection.doc(user.email).update({'image': imageUrl});
    } catch (e) {
      return;
    }
  }
}
