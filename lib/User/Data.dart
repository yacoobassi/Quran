import 'package:flutter/cupertino.dart';

import '../../Chat/models/user_model.dart';

class Data {
  static bool enterChat = false;
  static String sender = "";
  static UserModel user;
  static int bage = 0;
  static ValueNotifier<int> badgeCount = ValueNotifier<int>(0);
}
