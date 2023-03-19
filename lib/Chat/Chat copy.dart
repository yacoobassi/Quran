// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'package:test_ro_run/Chat/screens/home_screen.dart';

// import '../Data.dart';
// import 'models/user_model.dart';

// class Chat extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new FutureBuilder(
//         future: userSignedIn(),
//         builder: (context, AsyncSnapshot<Widget> snapshot) {
//           if (snapshot.hasData) {
//             return snapshot.data;
//           }
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         });
//     ;
//   }
// }

// Future<Widget> userSignedIn() async {
//   if (Data.user != null) {
//     print(Data.user.uid);
//     DocumentSnapshot userData = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(Data.user.email)
//         .get();
//     UserModel userModel = await UserModel.fromJson(userData);
//     return HomeScreen(userModel);
//   }
// }
