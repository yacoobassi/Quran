import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../showImage.dart';

class SingleMessage extends StatelessWidget {
  final String message, type, path;
  final bool isMe, reach;
  SingleMessage({
    this.message,
    this.isMe,
    this.type,
    this.path,
    this.reach,
  });
  @override
  Widget build(BuildContext context) {
    Uri uri = Uri.tryParse(message);
    return Row(
      mainAxisAlignment:
          !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        isMe
            ? Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: reach ? Colors.green : Colors.white,
                ),
                child: reach
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )
                    : CircularProgressIndicator())
            : SizedBox(),
        Container(
            padding: EdgeInsets.all(type == "image" ? 1 : 16),
            margin: EdgeInsets.only(top: 16, bottom: 16, right: 5),
            constraints: BoxConstraints(maxWidth: 200),
            decoration: BoxDecoration(
                color: isMe ? Colors.green : Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: type == "text"
                ? Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return showImage(message, true);
                      }));
                    },
                    child: (uri != null && uri.hasScheme && uri.hasAuthority)
                        ? ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl: message,
                              width: 250,
                            ),
                          )
                        : Container(child: Image.file(File(message))),
                  ))
      ],
    );
  }
}
