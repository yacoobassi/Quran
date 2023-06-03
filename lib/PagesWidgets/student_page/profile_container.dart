import 'dart:io';

import 'package:badges/badges.dart';
import 'package:badges/src/badge.dart' as badge;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:test_ro_run/User/Data.dart';
import '../../image.dart';

class profile_container extends StatefulWidget {
  double width;

  profile_container({Key myKey, this.width}) : super(key: myKey);
  @override
  State<profile_container> createState() => _profile_containerState();
}

class _profile_containerState extends State<profile_container> {
  File _image;
  final image = ImageHelper();

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
            onTap: () {},
            child: Container(
              child: InkWell(
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(Data.user.email)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        radius: 35.0,
                        backgroundImage: NetworkImage(snapshot.data['image']),
                        backgroundColor: Colors.transparent,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
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

                    await UpdateUserImage(
                      cropfiles.path,
                    );
                  }
                  setState(() {});
                },
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(Data.user.email)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data['name'],
                  style: TextStyle(fontSize: 20),
                );
              } else {
                return Text("");
              }
            },
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

UpdateUserImage(String path) async {
  try {
    final storageReference =
        FirebaseStorage.instance.ref().child("images/" + Data.user.email);

    await storageReference.putFile(File(path));
    String imageUrl = await storageReference.getDownloadURL();

    var collection = await FirebaseFirestore.instance.collection('users');

    await collection.doc(Data.user.email).update({'image': imageUrl});
  } catch (e) {
    return;
  }
}
