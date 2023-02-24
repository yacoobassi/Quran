// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:Quran/pages/stdPage.dart';
import 'package:flutter/material.dart';

import 'package:Quran/newChating/components/constants.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../image.dart';
import '../../camera/cameraPage.dart';
import '../ChatMessage.dart';

class ChatInputField extends StatefulWidget {
  Function refresh, scroll, showEmoji, closeEmoji;
  TextEditingController textController;
  bool Icons_visible;
  ChatInputField({
    Key key,
    this.refresh,
    this.scroll,
    this.showEmoji,
    this.closeEmoji,
    this.textController,
    this.Icons_visible,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  FocusNode focus;
  Icon send;

  final image = ImageHelper();

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    focus = new FocusNode();
    focus.addListener(() {
      if (focus.hasFocus) {
        widget.closeEmoji();
      }
    });
    widget.textController.addListener(() {
      widget.refresh();
    });
    send = Icon(Icons.mic, color: kPrimaryColor);
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            widget.textController.text == ""
                ? Icon(Icons.mic, color: kPrimaryColor)
                : InkWell(
                    onTap: () {
                      setState(() {
                        demeChatMessages.add(ChatMessage(
                          text: widget.textController.text,
                          messageType: ChatMessageType.text,
                          messageStatus: MessageStatus.viewed,
                          isSender: false,
                        ));
                        widget.textController.clear();
                      });
                      widget.refresh();
                      widget.scroll();
                    },
                    child: Icon(
                      Icons.send,
                      color: kPrimaryColor,
                    ),
                  ),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.64),
                      ),
                      onTap: () {
                        focus.unfocus();
                        focus.canRequestFocus = false;
                        widget.showEmoji();
                      },
                    ),
                    SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: 3,
                        focusNode: focus,
                        controller: widget.textController,
                        onEditingComplete: () {
                          setState(() {
                            demeChatMessages.add(ChatMessage(
                              text: widget.textController.text,
                              messageType: ChatMessageType.text,
                              messageStatus: MessageStatus.viewed,
                              isSender: false,
                            ));
                            widget.textController.clear();
                          });
                          widget.refresh();
                          widget.scroll();
                        },
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Visibility(
                        visible: widget.Icons_visible,
                        child: InkWell(
                            child:
                                Icon(Icons.attach_file, color: kPrimaryColor))),
                    SizedBox(width: kDefaultPadding / 2),
                    Visibility(
                      visible: widget.Icons_visible,
                      child: InkWell(
                        onTap: () async {
                          final files = await image.pickImage();
                          if (files.isNotEmpty) {
                            demeChatMessages.add(ChatMessage(
                              text: files.first.path,
                              messageType: ChatMessageType.video,
                              messageStatus: MessageStatus.viewed,
                              isSender: false,
                            ));

                            widget.refresh();
                            widget.scroll();
                          }
                          // if (files.isNotEmpty) {
                          //   final cropfiles = await image.crop(
                          //       file: files.first, cropStyle: CropStyle.circle);
                          //   if (cropfiles != null) {
                          //     setState(() => _image = File(
                          //           cropfiles.path,
                          //         ));
                          //   }
                          // }
                        },
                        child: Icon(Icons.image, color: kPrimaryColor),
                      ),
                    ),
                    SizedBox(width: kDefaultPadding / 2),
                    Visibility(
                      visible: widget.Icons_visible,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return CameraPage(
                                scroll: widget.scroll, refresh: widget.refresh);
                          }));
                        },
                        child: Icon(Icons.camera_alt, color: kPrimaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
