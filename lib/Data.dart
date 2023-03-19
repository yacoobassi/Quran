import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Data {
  static bool enterChat = false;
  static String sender = "";
  static User user;
  static int bage = 0;
  static ValueNotifier<int> badgeCount = ValueNotifier<int>(0);
}
