import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();

    initializeDatabaseForDesktopMachines();
  }

  var logger = Logger();

  runApp(App(logger: logger));
}

void initializeDatabaseForDesktopMachines() async {
  var databaseFactory = databaseFactoryFfi;

  String path = join(
    '${Platform.resolvedExecutable.toString().replaceAll('zipcodeph_flutter.exe', '')}data\\flutter_assets\\assets\\',
    'zips_ph.db',
  );
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class App extends StatelessWidget {
  const App({super.key, required this.logger});

  final Logger logger;

  @override
  Widget build(BuildContext context) {
    logger.i("Setting overlay style");
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
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
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: MainMenu(logger: logger),
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
