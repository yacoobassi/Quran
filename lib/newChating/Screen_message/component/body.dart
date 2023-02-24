import 'dart:io';

import 'package:Quran/newChating/components/constants.dart';
import 'package:Quran/newChating/Screen_message/ChatMessage.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

final TextEditingController _message = new TextEditingController();

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
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ListView.builder(
                controller: _controller,
                itemCount: demeChatMessages.length,
                itemBuilder: (context, index) =>
                    Message(message: demeChatMessages[index]),
              ),
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
