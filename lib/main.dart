import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zipcodeph_flutter/views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Brightness theme = MediaQuery.of(context).platformBrightness;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: (theme == Brightness.dark) ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: (theme == Brightness.dark) ? Brightness.light : Brightness.dark, //
      statusBarColor:
          Colors.transparent, // or set color with: Color(0xFF0000FF)
    ));

    return MaterialApp(
      title: 'ZIP Code PH',
      home: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            child: const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 0.0),
                child: MainMenu(),
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
