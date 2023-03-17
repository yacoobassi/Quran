import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignNewUser {
  static Future signUpFunction(String name, String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //   GoogleSignInAccount googleUser = await googleSignIn.signIn();
    // if (googleUser == null) {
    //   return;
    // }
    // final googleAuth = await googleUser.authentication;
    // final credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    // UserCredential userCredential =
    //     await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExist =
        await firestore.collection('users').doc(email).get();

    if (userExist.exists) {
      print("User Already Exists in Database");
      // SharedPreferences pref = await SharedPreferences.getInstance();
      // final _auth = FirebaseAuth.instance;
      // _auth.signInWithEmailAndPassword(email: email, password: "password");

      // pref.setString("id", email);
      // pref.setString('image',
      //     "https://icon-library.com/images/profile-male-circle2-512_56473.png");
    } else {
      //  SharedPreferences pref = await SharedPreferences.getInstance();

      //  pref.setString("id", email);
      //  pref.setString('image',
      //     "https://icon-library.com/images/profile-male-circle2-512_56473.png");

      final _auth = await FirebaseAuth.instance;
      _auth.createUserWithEmailAndPassword(email: email, password: "password");

      await firestore.collection('users').doc(email).set({
        'email': email,
        'name': name,
        'image':
            "https://icon-library.com/images/profile-male-circle2-512_56473.png",
        'uid': email,
        'date': DateTime.now(),
        'token': ""
      });
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: NetworkImage(
//                             "https://cdn.iconscout.com/icon/free/png-256/chat-2639493-2187526.png"))),
//               ),
//             ),
//             Text(
//               "Flutter Chat App",
//               style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   await signUpFunction(Str);
//                   User user = await FirebaseAuth.instance.currentUser;

//                   DocumentSnapshot userData = await FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(user.uid)
//                       .get();
//                   UserModel userModel = await UserModel.fromJson(userData);

//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Chat()),
//                   );
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.network(
//                       'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
//                       height: 36,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       "Sign in With Google",
//                       style: TextStyle(fontSize: 20),
//                     )
//                   ],
//                 ),
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Colors.black),
//                     padding: MaterialStateProperty.all(
//                         EdgeInsets.symmetric(vertical: 12))),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
}
