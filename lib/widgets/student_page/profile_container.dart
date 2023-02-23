import 'dart:io';

import 'package:badges/badges.dart';
import 'package:badges/src/badge.dart' as badge;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../image.dart';

class profile_container extends StatefulWidget {
  double width;
  String name;
  profile_container({Key myKey, this.width, this.name}) : super(key: myKey);
  @override
  State<profile_container> createState() => _profile_containerState();
}

class _profile_containerState extends State<profile_container> {
  File _image;
  final image = ImageHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 80),
        padding: EdgeInsets.only(top: 20),
        width: widget.width,
        height: 170,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          badge.Badge(
            badgeContent: Icon(Icons.edit),
            badgeStyle: BadgeStyle(badgeColor: Colors.white),
            position: BadgePosition.bottomStart(),
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
              }
            },
            child: InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: 35,
                foregroundImage: _image != null ? FileImage(_image) : null,
                child: Text(""),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${widget.name}",
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "  مرحبا بك",
              ),
              Container(
                width: 15,
                height: 15,
                child: Image.asset("images/heart.png"),
              ),
            ],
          ),
        ]));
  }
}
