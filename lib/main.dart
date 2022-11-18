import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ZIP Code PH',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: MainMenu(),
    );
  }

  ThemeData _buildTheme(brightness) {
    return ThemeData(
      primarySwatch: Colors.red,
      brightness: brightness,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
