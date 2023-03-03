import 'dart:io';
import 'package:Quran/newChating/firebase/services/shared.dart';

import 'package:Quran/newChating/components/constants.dart';
import 'package:Quran/newChating/Screen_message/ChatMessage.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../firebase/constants.dart';
import '../../firebase/services/database.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  String id;
  Stream chats;
  Body(this.id, this.chats) {}
}

final TextEditingController _message = new TextEditingController();
DataBase dataBase = new DataBase();

class _BodyState extends State<Body> {
  ScrollController _controller;
  bool showemoji;
  File imageToSend;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = ScrollController();
    showemoji = false;
  }

  Widget chatList() {
    return StreamBuilder(
      stream: widget.chats,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return MessageTile(
                  message: snapshot.data.docs[index]["message"],
                  sendByMe:
                      Constant.myName == snapshot.data.docs[index]["sendBy"],
                );
              });
        } else {
          return Container();
        }
      },
    );
  }

  refresh() {
    if (this.mounted) {
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    final bool show_icons =
        !KeyboardVisibilityProvider.isKeyboardVisible(context);
    Future _scrollDown() async {
      await Future.delayed(Duration(milliseconds: 300), () {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      });
    }

    Future showEmojiOnTap() async {
      await Future.delayed(Duration(milliseconds: 100), () {
        showemoji = !showemoji;
        setState(() {});
      });
    }

    closeEmoji() {
      showemoji = false;
      setState(() {});
    }

    return WillPopScope(
      onWillPop: () {
        if (showemoji) {
          setState(() {
            showemoji = false;
          });
        } else {
          _message.clear();
          Navigator.pop(context);
        }
        return Future.value(false);
      },
      child: Column(
        children: [
          Expanded(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: chatList()
                // child: ListView.builder(
                //   controller: _controller,
                //   itemCount: demeChatMessages.length,
                //   itemBuilder: (context, index) =>
                //       Message(message: demeChatMessages[index]),
                // ),
                ),
          ),
          Column(
            children: [
              ChatInputField(
                refresh: refresh,
                scroll: _scrollDown,
                showEmoji: showEmojiOnTap,
                closeEmoji: closeEmoji,
                textController: _message,
                Icons_visible: show_icons,
                chatRoomId: widget.id,
              ),
              showemoji
                  ? SizedBox(
                      width: double.infinity, height: 250, child: showEmoji())
                  : SizedBox()
            ],
          )
        ],
      ),
    );
  }
}

Widget showEmoji() {
  return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        _message.text = _message.text + emoji.emoji;
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

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
                colors: sendByMe
                    ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                    : [
                        Color.fromARGB(255, 0, 244, 53),
                        Color.fromARGB(255, 0, 244, 53),
                      ])),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
