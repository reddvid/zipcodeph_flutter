import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../views/mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,//
      statusBarColor: Colors.transparent,// or set color with: Color(0xFF0000FF)
    ));
    return MaterialApp(
      title: 'ZIP Code PH',
      builder: (context, widget) => ResponsiveBreakpoints.builder(
        child: ClampingScrollWrapper.builder(context, widget!),
        breakpoints: [
          const Breakpoint(start: 0, end: 800, name: MOBILE),
          const Breakpoint(start: 0, end: 1200, name: TABLET),
          const Breakpoint(start: 0, end: 1920, name: DESKTOP),
        ],
      ),
      home: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            child: const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: MainMenu(),
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      themeMode: ThemeMode.system,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
    );
  }
}
