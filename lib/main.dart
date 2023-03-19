import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:test_ro_run/pages/sign_in.dart';
import 'package:test_ro_run/pages/stdPage.dart';
import 'package:test_ro_run/sharedPref.dart';
import 'Data.dart';

void main() async {
// Navigate to chat page

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseAuth auth = FirebaseAuth.instance;
  Data.user = auth.currentUser;
// Initialize the plugin

  await FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (!Data.enterChat) {
      Data.badgeCount.value++;

      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(AssetSource('Message.mp3'));

      Pref.setNotifications(
        message.data['status'],
      );
    }
  });
  await FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          Locale('ar', 'US')
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Hacen"),
        title: 'Flutter Demo',
        home: Data.user == null ? Signin() : student_page());
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Pref.setNotifications(message.data['status']);
  //Data.badgeCount.value++;
}
