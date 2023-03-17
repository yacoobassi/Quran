import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Chat/models/user_model.dart';

class Pref {
  static List messages = [];

  static setNotifications(String id) async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
    var image = snap['image'];
    var name = snap['name'];
    final _auth = await FirebaseAuth.instance;
    final user = await _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .get();
      UserModel userModel = await UserModel.fromJson(userData);
      Map<String, dynamic> userModelJson = userModel.toJson();
      var dateTime = DateTime.now();
      String jsonString = dateTime.toIso8601String();
      messages.add({
        'userModel': userModelJson,
        'id': id,
        'name': name,
        "date": jsonString,
        "image": image
      });

      //  http.Response response = await http.get(Uri.parse(widget.imageUrl));
      //   imageBytes = response.bodyBytes;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonData = jsonEncode(messages);
      await prefs.setString('Notifications', jsonData);
    }
  }

  static getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('Notifications');
    if (jsonData != null) {
      List<dynamic> decodedData = jsonDecode(jsonData);
      return decodedData.cast<Map<String, dynamic>>();
    }
  }

  static setUser(String Id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userId', Id);
  }

  static Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString('userId');
  }

  static setProfileImage(String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('profileImage', image);
  }

  static getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString('profileImage');
  }

  static setUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userName', name);
  }

  static getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString('userName');
  }
}
