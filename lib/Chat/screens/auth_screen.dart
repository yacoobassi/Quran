import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignNewUser {
  static Future signUpFunction(String name, String email, bool student,
      String institute, String regiment, String password) async {
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
        "student": student
      });
    }
  }
}
