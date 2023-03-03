import 'package:firebase_auth/firebase_auth.dart';
import 'package:Quran/newChating/firebase/modul/user.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser _user(User user) {
    return user != null ? FirebaseUser(userId: user.uid) : null;
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User firebaseuser = result.user;
      return _user(firebaseuser);
    } catch (e) {
      print(e);
    }
  }

  Future signup(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User firebaseuser = result.user;
      return _user(firebaseuser);
    } catch (e) {
      print(e);
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("reset passs error");
    }
  }

  Future signout() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print("sign out error");
    }
  }
}
