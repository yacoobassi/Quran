import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:badges/src/badge.dart' as badge;
import '../../Links.dart';
import '../../User/Data.dart';
import '../../request.dart';
import '../../showImage.dart';

class AddPostScreen extends StatefulWidget {
  final Function setImage;
  final Function refresh;
  final File image;

  AddPostScreen(this.setImage, this.refresh, this.image);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final picker = ImagePicker();
  final _commentController = TextEditingController();
  bool _isComposing = false;

  Future<void> _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.setImage(File(pickedFile.path));
    }
  }

  Future<void> _post(String name, String image64) async {
    final request = Requst();
    final response = await request.postRequest(newPost, {
      "teacher": Data.user.email.replaceAll("@gmail.com", ""),
      "date": DateTime.now().toString(),
      "comment": _commentController.text,
      "reginmentNum": Data.user.regiment,
      "instituteNum": Data.user.institute,
      "commentsNum": "0",
      "likesNum": "0",
      "imageName": name,
      "image64": image64,
    });
    return response;
  }

  Future<void> _uploadImage() async {
    if (widget.image == null) return;

    final base64 = base64Encode(widget.image.readAsBytesSync());
    final imageName = widget.image.path.split("/").last;
    await _post(imageName, base64);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              ClipOval(
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(Data.user.email)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return InkWell(
                        child: CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(snapshot.data['image']),
                          backgroundColor: Colors.transparent,
                        ),
                        onTap: () {
                          return Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return showImage(snapshot.data['image'], true);
                          }));
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 120.0,
                  ),
                  child: TextFormField(
                    controller: _commentController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onChanged: (String text) {
                      setState(() {
                        _isComposing = text.trim().isNotEmpty;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'اضافة منشور...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          if (widget.image != null)
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return showImage(widget.image.path, false);
                }));
              },
              child: badge.Badge(
                badgeStyle: const BadgeStyle(badgeColor: Colors.white),
                position: BadgePosition.topEnd(top: -5, end: 5),
                badgeContent: InkWell(
                  onTap: () {
                    widget.setImage(null);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    child: const Text(
                      "x",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  // decoration: const BoxDecoration(
                  //   border: Border.all(color: Colors.grey),
                  // ),
                  child: Image.file(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 80,
                  child: IconButton(
                    icon: Icon(
                      Icons.add_a_photo_rounded,
                      size: 70,
                    ),
                    onPressed: () {
                      _getImage();
                    },
                  ),
                ),
              ],
            ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: ElevatedButton(
              child: Text("نشر"),
              onPressed: () async {
                await _uploadImage();
                _commentController.clear();

                widget.setImage(null);
                widget.refresh();
              },
            ),
          ),
        ],
      ),
    );
  }
}
