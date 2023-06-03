import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_ro_run/Chat/camera/camera_scareen.dart';
import 'package:test_ro_run/Chat/sendNotification.dart';
import 'package:uuid/uuid.dart';

import '../../User/Data.dart';
import '../../image.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;
  Function ShowEmoji, ifReach, closeKeyboard, closeEmoji;

  MessageTextField(this.currentId, this.friendId, this.ShowEmoji, this.ifReach,
      this.closeKeyboard, this.closeEmoji);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

TextEditingController _controller = TextEditingController();
FirebaseMessaging fMessaging = FirebaseMessaging.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class _MessageTextFieldState extends State<MessageTextField> {
  bool showPictures = true;
  String mytoken = "";
  final image = ImageHelper();
  var uuid = Uuid();
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      print("object");
      myFocusNode.hasFocus ? showPictures = false : showPictures = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsetsDirectional.all(8),
      child: Stack(children: [
        Row(
          children: [
            Visibility(
                visible: showPictures,
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.image,
                        color: Colors.green,
                        size: 30,
                      ),
                      onTap: () async {
                        final pickedFile = await ImagePicker().getImage(
                            source: ImageSource.gallery, imageQuality: 50);
                        if (pickedFile.path.isNotEmpty) {
                          try {
                            print("object1");
                            final storageReference = FirebaseStorage.instance
                                .ref()
                                .child("images/" + DateTime.now().toString());

                            await FirebaseFirestore.instance
                                .collection('users');

                            var uid = uuid.v4();
                            print("object2");

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.currentId)
                                .collection('messages')
                                .doc(widget.friendId)
                                .collection('chats')
                                .doc(uid)
                                .set({
                              "senderId": widget.currentId,
                              "receiverId": widget.friendId,
                              "message": pickedFile.path,
                              "type": "image",
                              "date": DateTime.now(),
                              "reach": false
                            }).then((value) async {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.currentId)
                                  .collection('messages')
                                  .doc(widget.friendId)
                                  .set({"last_msg": "📸 صورة"});
                            });
                            await storageReference
                                .putFile(File(pickedFile.path));

                            String imageUrl =
                                await storageReference.getDownloadURL();

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.currentId)
                                .collection('messages')
                                .doc(widget.friendId)
                                .collection('chats')
                                .doc(uid)
                                .set({
                              "senderId": widget.currentId,
                              "receiverId": widget.friendId,
                              "message": imageUrl,
                              "type": "image",
                              "date": DateTime.now(),
                              "reach": false
                            }).then((value) async {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.currentId)
                                  .collection('messages')
                                  .doc(widget.friendId)
                                  .collection('chats')
                                  .doc(uid)
                                  .update({"reach": true});
                              AudioPlayer audioPlayer = AudioPlayer();
                              await audioPlayer.play(AssetSource('sent.mp3'));
                              DocumentSnapshot snap = await FirebaseFirestore
                                  .instance
                                  .collection("users")
                                  .doc(widget.friendId)
                                  .get();

                              DocumentSnapshot snap2 = await FirebaseFirestore
                                  .instance
                                  .collection("users")
                                  .doc(widget.currentId)
                                  .get();

                              String token = snap['token'];
                              String title = snap2['name'];

                              sendNot.sendPushNotification(
                                  token, "📸 صورة", title, widget.currentId);
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.currentId)
                                  .collection('messages')
                                  .doc(widget.friendId)
                                  .collection('chats')
                                  .doc(uid)
                                  .update({"reach": true, "message": imageUrl});

                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.currentId)
                                  .collection('messages')
                                  .doc(widget.friendId)
                                  .set({"last_msg": "📸 صورة"});
                            });
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.friendId)
                                .collection('messages')
                                .doc(widget.currentId)
                                .collection("chats")
                                .doc(uid)
                                .set({
                              "senderId": widget.currentId,
                              "receiverId": widget.friendId,
                              "message": imageUrl,
                              "type": "image",
                              "date": DateTime.now(),
                              "reach": true
                            }).then((value) async {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.friendId)
                                  .collection('messages')
                                  .doc(widget.currentId)
                                  .set({"last_msg": "📸 صورة"});
                            });
                          } catch (e) {
                            return;
                          }
                        }
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.green,
                        size: 30,
                      ),
                      onTap: () async {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CameraScreen(
                              widget.currentId, widget.friendId);
                        }));
                      },
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                )),
            InkWell(
                onTap: () {
                  widget.closeKeyboard();
                  widget.ShowEmoji();
                },
                child: SizedBox(
                  child: Icon(
                    Icons.emoji_emotions_outlined,
                    size: 30,
                    color: Colors.green,
                  ),
                )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: TextField(
              onTap: () {
                widget.closeEmoji();
              },
              minLines: 1,
              maxLines: 3,
              focusNode: myFocusNode,
              controller: _controller,
              decoration: InputDecoration(
                  hintText: "ادخل نص",
                  fillColor: Colors.grey[100],
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0),
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(25))),
            )),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () async {
                var uid = uuid.v4();
                String message = _controller.text;
                _controller.clear();
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.currentId)
                    .collection('messages')
                    .doc(widget.friendId)
                    .collection('chats')
                    .doc(uid)
                    .set({
                  "senderId": widget.currentId,
                  "receiverId": widget.friendId,
                  "message": message,
                  "type": "text",
                  "date": DateTime.now(),
                  "reach": false
                }).then((value) async {
                  AudioPlayer audioPlayer = AudioPlayer();
                  await audioPlayer.play(AssetSource('sent.mp3'));
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.currentId)
                      .collection('messages')
                      .doc(widget.friendId)
                      .collection('chats')
                      .doc(uid)
                      .update({"reach": true});
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.currentId)
                      .collection('messages')
                      .doc(widget.friendId)
                      .set({
                    'last_msg': message,
                  });
                });

                DocumentSnapshot snap = await FirebaseFirestore.instance
                    .collection("users")
                    .doc(widget.friendId)
                    .get();
                DocumentSnapshot snap2 = await FirebaseFirestore.instance
                    .collection("users")
                    .doc(widget.currentId)
                    .get();

                String token = snap['token'];
                String title = snap2['name'];

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(Data.user.email)
                    .get();
                sendNot.sendPushNotification(
                    token, title, message, widget.currentId);
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.friendId)
                    .collection('messages')
                    .doc(widget.currentId)
                    .collection("chats")
                    .add({
                  "senderId": widget.currentId,
                  "receiverId": widget.friendId,
                  "message": message,
                  "type": "text",
                  "date": DateTime.now(),
                  "reach": true
                }).then((value) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.friendId)
                      .collection('messages')
                      .doc(widget.currentId)
                      .set({"last_msg": message});
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }

  Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        firestore.collection('users').doc(Data.user.email).update({'token': t});

        log('Push Token: $t');
      }
    });
  }
}

Widget showEmoji() {
  return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        _controller.text = _controller.text + emoji.emoji;
      },
      config: Config(
        columns: 7,
        initCategory: Category.SMILEYS,
        bgColor: const Color(0xFFF2F2F2),
        indicatorColor: Colors.blue,
        iconColor: Colors.grey,
        iconColorSelected: Colors.blue,
        backspaceColor: Colors.blue,
        skinToneDialogBgColor: Colors.white,
        skinToneIndicatorColor: Colors.grey,
        enableSkinTones: true,
        showRecentsTab: true,
        recentsLimit: 28,
        replaceEmojiOnLimitExceed: false,
        noRecents: const Text(
          'No Recents',
          style: TextStyle(fontSize: 20, color: Colors.black26),
          textAlign: TextAlign.center,
        ),
        loadingIndicator: const SizedBox.shrink(),
        tabIndicatorAnimDuration: kTabScrollDuration,
        categoryIcons: const CategoryIcons(),
        buttonMode: ButtonMode.MATERIAL,
        checkPlatformCompatibility: true,
      ));
}
