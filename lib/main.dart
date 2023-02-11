import 'package:Quran/pages/new_pass.dart';
import 'package:Quran/pages/posts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Quran",
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale('ar', 'US')],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Hacen"),
        home: posts());
  }
}
