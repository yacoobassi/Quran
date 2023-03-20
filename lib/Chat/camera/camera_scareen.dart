import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:test_ro_run/Chat/sendNotification.dart';

import 'cameraView.dart';

List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  String currentId, friendId;
  CameraScreen(this.currentId, this.friendId);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController;
  Future<void> cameraValue;
  bool isRecoring = false;
  bool flash = false;
  bool iscamerafront = true;

  double transform = 0;

  @override
  void initState() {
    super.initState();
    _setupCameras();
  }

  Future<void> _setupCameras() async {
    try {
      // initialize cameras.
      cameras = await availableCameras();
      // initialize camera controllers.
      _cameraController =
          new CameraController(cameras[0], ResolutionPreset.medium);
      cameraValue = _cameraController.initialize();
    } on CameraException catch (_) {
      // do something on error.
    }
    if (!mounted) return;
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });
                            flash
                                ? _cameraController
                                    .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          }),
                      GestureDetector(
                        onLongPress: () async {
                          await _cameraController.startVideoRecording();
                          setState(() {
                            isRecoring = true;
                          });
                        },
                        onTap: () {
                          if (!isRecoring) takePhoto(context);
                        },
                        child: isRecoring
                            ? Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 80,
                              )
                            : Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      IconButton(
                          icon: Transform.rotate(
                            angle: transform,
                            child: Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              iscamerafront = !iscamerafront;
                              transform = transform + pi;
                            });
                            int cameraPos = iscamerafront ? 0 : 1;
                            _cameraController = CameraController(
                                cameras[cameraPos], ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "التقط صورة",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    try {
      XFile file = await _cameraController.takePicture();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => CameraViewPage(
                    path: file.path,
                  )));

      if (file.path.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users');
        const uuid = Uuid();
        var uid = uuid.v4();
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
          "message": file.path,
          "type": "image",
          "date": DateTime.now(),
          "original": file.path,
          "reach": false
        }).then((value) async {
          DocumentSnapshot snap = await FirebaseFirestore.instance
              .collection("users")
              .doc(widget.friendId)
              .get();

          String token = snap['token'];
          String title = snap['name'];
          sendNot.sendPushNotification(
              token, "📸 صورة", title, widget.currentId);
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
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.currentId)
              .collection('messages')
              .doc(widget.friendId)
              .set({"last_msg": "📸 صورة"});
        });

        final storageReference = FirebaseStorage.instance
            .ref()
            .child("images/" + DateTime.now().toString());
        await storageReference.putFile(File(file.path));

        String imageUrl = await storageReference.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.currentId)
            .collection('messages')
            .doc(widget.friendId)
            .collection('chats')
            .doc(uid)
            .update({"message": imageUrl, "reach": true}).then((value) async {
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
              .set({"last_msg": "📸 صورة"});
        });

        await FirebaseFirestore.instance
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
      }
    } catch (e) {
      return;
    }
  }
}
