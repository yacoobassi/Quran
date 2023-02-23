import 'dart:io';

import 'package:Quran/newChating/Screen_message/ChatMessage.dart';
import 'package:Quran/newChating/Screen_message/component/message.dart';
import 'package:flutter/material.dart';

import 'package:Quran/newChating/components/constants.dart';

class VideoMessage extends StatelessWidget {
  VideoMessage({Key key, this.message}) : super(key: key);

  ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(File(message.text)),
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
        ),
      ),
    );
  }
}
