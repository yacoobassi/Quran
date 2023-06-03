import 'package:cloud_firestore/cloud_firestore.dart';

import 'User/Data.dart';

class Pref {
  static List messages = [];

  static setNotifications(String id) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(Data.user.email)
        .collection("messages")
        .add({
      "senderId": id,
      "time": DateTime.now(),
    });
  }
}
