import 'dart:io';

import 'package:Quran/newChating/Screen_message/ChatMessage.dart';
import 'package:Quran/newChating/Screen_message/component/message.dart';
import 'package:flutter/material.dart';

import 'package:Quran/newChating/components/constants.dart';

import '../../showImage.dart';

class VideoMessage extends StatefulWidget {
  VideoMessage({Key key, this.message}) : super(key: key);

  ChatMessage message;

  @override
  State<VideoMessage> createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  double width = 150;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          child: SizedBox(
            width: width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(File(widget.message.text)),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return showImage(image: widget.message.text);
            }));
          },
        ),

        // Container(
        //   height: 25,
        //   width: 25,
        //   decoration: BoxDecoration(
        //     color: kPrimaryColor,
        //     shape: BoxShape.circle,
        //   ),
        //   child: Icon(
        //     Icons.play_arrow,
        //     size: 16,
        //     color: Colors.white,
        //   ),
        // )
      ],
    );
  }
}
