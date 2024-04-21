import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../views/mainpage.dart';

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
    return MaterialApp(
      title: 'ZIP Code PH',
      builder: (context, widget) => ResponsiveBreakpoints.builder(
        child: ClampingScrollWrapper.builder(context, widget!),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 0, end: 800, name: TABLET),
          const Breakpoint(start: 0, end: 1920, name: DESKTOP),
        ],
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1920, minWidth: 1920),
              child: const Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: MainMenu(),
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
    );
  }
}
