import 'package:cloud_firestore/cloud_firestore.dart';
import '../Chat/models/user_model.dart';
import 'Data.dart';

class GetUser {
  static Future userSignedIn(String email) async {
    DocumentSnapshot userData =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    Data.user = await UserModel.fromJson(userData);
    return Data.user;
  }
}
