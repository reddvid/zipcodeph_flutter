import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'themes/app_theme.dart';
import 'views/mainpage.dart';
import 'widgets/theme_status_bar.dart';

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

      // Light theme configuration
      theme: AppTheme.lightTheme,

      // Dark theme configuration
      darkTheme: AppTheme.darkTheme,

      // Follow system theme
      themeMode: ThemeMode.system,

      builder: (context, widget) => ResponsiveBreakpoints.builder(
        child: ClampingScrollWrapper.builder(context, widget!),
        breakpoints: [
          const Breakpoint(start: 0, end: 800, name: MOBILE),
          const Breakpoint(start: 0, end: 1200, name: TABLET),
          const Breakpoint(start: 0, end: 1920, name: DESKTOP),
        ],
      ),
      home: ThemeStatusBar(
        child: Scaffold(
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
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
    );
  }
}
