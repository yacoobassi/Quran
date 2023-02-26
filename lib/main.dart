import 'package:Quran/firebase_options.dart';
import 'package:Quran/pages/Student_table.dart';
import 'package:Quran/pages/new_pass.dart';
import 'package:Quran/pages/posts.dart';
import 'package:Quran/pages/sign_in.dart';
import 'package:Quran/pages/signup.dart';
import 'package:Quran/pages/stdPage.dart';
import 'package:Quran/pages/teacherPage.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'newChating/Screen_Chats/chat_screen.dart';
import 'newChating/camera/cameraPage.dart';
import 'newChating/camera/camera_scareen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MaterialApp(
        title: "Quran",
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale('ar', 'US')],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Hacen"),
        home: Table_student1(),
      ),
    );
  }
}
