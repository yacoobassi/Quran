import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/showImage.dart';

import '../models/user_model.dart';
import '../widgets/message_textfield.dart';
import '../widgets/single_message.dart';
import 'package:test_ro_run/User/Data.dart';

class ChatScreen extends StatefulWidget {
  final UserModel currentUser;
  final String friendId;
  final String friendName;
  final String friendImage;

  ChatScreen({
    this.currentUser,
    this.friendId,
    this.friendName,
    this.friendImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

bool emojiShow, reach, showPictures;

class _ChatScreenState extends State<ChatScreen> {
  ShowEmoji() {
    setState(() {
      emojiShow = !emojiShow;
      print("object");
    });
  }

  closeEmoji() {
    setState(() {
      emojiShow = false;
    });
  }

  @override
  void initState() {
    super.initState();
    emojiShow = false;
    reach = false;
    Data.enterChat = true;
    Data.sender = "55";
    showPictures = true;
  }

  setEnter() async {}

  @override
  void deactivate() {
    super.deactivate();
    Data.enterChat = false;
  }

  ifReach() {
    setState(() {
      reach = true;
    });
  }

  closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      setState(() {
        showPictures = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        closeKeyboard();
        if (emojiShow) {
          setState(() {
            emojiShow = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: CircleAvatar(
                    radius: 22.0,
                    backgroundImage: NetworkImage(widget.friendImage),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return showImage(widget.friendImage, true);
                  }));
                },
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                widget.friendName,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(widget.currentUser.uid)
                      .collection('messages')
                      .doc(widget.friendId)
                      .collection('chats')
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length < 1) {
                        return Center(
                          child: Text("Say Hi"),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          reverse: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            bool isMe = snapshot.data.docs[index]['senderId'] ==
                                widget.currentUser.uid;

                            String type = snapshot.data.docs[index]['type'];

                            return SingleMessage(
                                message: snapshot.data.docs[index]['message'],
                                isMe: isMe,
                                type: type,
                                reach: snapshot.data.docs[index]['reach']);
                          });
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            )),
            Column(
              children: [
                MessageTextField(widget.currentUser.uid, widget.friendId,
                    ShowEmoji, ifReach, closeKeyboard, closeEmoji),
                emojiShow
                    ? SizedBox(
                        width: double.infinity, height: 250, child: showEmoji())
                    : SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}
