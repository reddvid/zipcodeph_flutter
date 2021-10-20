import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/views/mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.red,
          brightness: Brightness.light,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          })
          /* light theme settings */
          ),
      darkTheme: ThemeData(
          primarySwatch: Colors.red,
          brightness: Brightness.dark,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          })
          /* dark theme settings */
          ),
      themeMode: ThemeMode.system,
      home: const MainMenu(),
    );
  }
}
