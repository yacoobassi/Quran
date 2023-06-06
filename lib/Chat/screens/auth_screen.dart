import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../User/Data.dart';

class SignNewUser {
  static Future signUpFunction(
      String name,
      String email,
      bool student,
      String institute,
      String regiment,
      String password,
      String instituteName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot userExist =
        await firestore.collection('users').doc(email).get();

    if (userExist.exists) {
      print("User Already Exists in Database");
    } else {
      final _auth = await FirebaseAuth.instance;
      _auth.createUserWithEmailAndPassword(email: email, password: password);

      await firestore.collection('users').doc(email).set({
        'email': email,
        'name': name,
        'image':
            "https://icon-library.com/images/profile-male-circle2-512_56473.png",
        'uid': email,
        'date': DateTime.now(),
        'token': "",
        "institute": institute,
        "regiment": regiment,
        "student": student,
        "instituteName": instituteName
      });
    }
  }
}

class DeleteUser {
  static Future deleteUser(String email) async {
    try {
      final _auth = FirebaseAuth.instance;
      final user = await _auth.currentUser;

      // Delete user from FirebaseAuth
      if (user != null) {
        await user.delete();
      } else {
        print("User does not exist in FirebaseAuth");
      }

      // Delete user from Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(email).delete();

      print("User deleted successfully");
    } catch (e) {
      print("Error deleting user: $e");
    }
  }
}

class ChangePassword {
  static Future changeUserPassword(String email, String newPassword) async {
    try {
      final _auth = FirebaseAuth.instance;
      final user = await _auth.currentUser;

      // Re-authenticate the user
      AuthCredential credential = EmailAuthProvider.credential(
          email: email, password: Data.user.password);
      await user.reauthenticateWithCredential(credential);

      // Change the password
      await user.updatePassword(newPassword);

      print("Password changed successfully");
    } catch (e) {
      print("Error changing password: $e");
    }
  }
}
