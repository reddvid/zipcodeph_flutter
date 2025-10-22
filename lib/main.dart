import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../views/mainpage.dart';
import '../views/searchpage.dart';
import '../views/favespage.dart';
import '../views/aboutpage.dart';
import '../services/navigation_service.dart';

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
      theme: ThemeData(
        // Main color scheme
        primarySwatch: Colors.red,
        primaryColor: Colors.red.shade800,

        // Font family - Inter
        fontFamily: GoogleFonts.inter().fontFamily,

        // Scaffold background - cream white
        scaffoldBackgroundColor: const Color(0xFFFFFDF7), // Cream white
        // App bar theme
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFFFFDF7), // Cream white
          elevation: 0,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Bottom navigation bar theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFFFFFDF7), // Cream white
          selectedItemColor: Colors.red.shade800,
          unselectedItemColor: Colors.grey.shade600,
          elevation: 8,
        ),

        // Card theme
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        // Text theme - Inter font
        textTheme: GoogleFonts.interTextTheme().copyWith(
          headlineLarge: GoogleFonts.inter(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: GoogleFonts.inter(color: Colors.grey.shade700),
          bodyMedium: GoogleFonts.inter(color: Colors.grey.shade600),
        ),

        // Button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade800,
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: GoogleFonts.inter(color: Colors.grey.shade500),
          labelStyle: GoogleFonts.inter(color: Colors.grey.shade700),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red.shade800, width: 2),
          ),
        ),

        // Snackbar theme
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.grey.shade800,
          contentTextStyle: GoogleFonts.inter(color: Colors.white),
          actionTextColor: Colors.red.shade400,
        ),
      ),

      // Dark theme configuration
      darkTheme: ThemeData(
        // Dark theme settings
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        primaryColor: Colors.red.shade400,

        // Font family - Inter
        fontFamily: GoogleFonts.inter().fontFamily,

        // Dark scaffold background - deep charcoal
        scaffoldBackgroundColor: const Color(0xFF1A1A1A), // Deep charcoal
        // Dark app bar theme
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF1A1A1A), // Deep charcoal
          elevation: 0,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Dark bottom navigation bar theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF2D2D2D), // Darker grey
          selectedItemColor: Colors.red.shade400,
          unselectedItemColor: Colors.grey.shade500,
          elevation: 8,
        ),

        // Dark card theme
        cardTheme: CardThemeData(
          color: const Color(0xFF2D2D2D), // Dark grey
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Dark text theme - Inter font
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
            .copyWith(
              headlineLarge: GoogleFonts.inter(
                color: Colors.grey.shade200,
                fontWeight: FontWeight.bold,
              ),
              bodyLarge: GoogleFonts.inter(color: Colors.grey.shade300),
              bodyMedium: GoogleFonts.inter(color: Colors.grey.shade400),
            ),

        // Dark button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Dark input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2D2D2D), // Dark grey
          hintStyle: GoogleFonts.inter(color: Colors.grey.shade500),
          labelStyle: GoogleFonts.inter(color: Colors.grey.shade300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade600),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red.shade400, width: 2),
          ),
        ),

        // Dark divider theme
        dividerTheme: DividerThemeData(
          color: Colors.grey.shade700,
          thickness: 1,
        ),

        // Dark list tile theme
        listTileTheme: ListTileThemeData(
          textColor: Colors.grey.shade300,
          iconColor: Colors.grey.shade400,
        ),

        // Dark snackbar theme
        snackBarTheme: SnackBarThemeData(
          backgroundColor: const Color(0xFF2D2D2D),
          contentTextStyle: GoogleFonts.inter(color: Colors.grey.shade200),
          actionTextColor: Colors.red.shade400,
        ),
      ),

      // Use system theme mode (light/dark)
      themeMode: ThemeMode.system,

      builder: (context, widget) => ResponsiveBreakpoints.builder(
        child: ClampingScrollWrapper.builder(context, widget!),
        breakpoints: [
          const Breakpoint(start: 0, end: 800, name: MOBILE),
          const Breakpoint(start: 0, end: 1200, name: TABLET),
          const Breakpoint(start: 0, end: 1920, name: DESKTOP),
        ],
      ),
      home: const MainAppWithBottomNav(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
    );
  }
}

final GlobalKey<MainAppWithBottomNavState> homePageKey = GlobalKey();

class MainAppWithBottomNav extends StatefulWidget {
  const MainAppWithBottomNav({Key? key}) : super(key: key);

  @override
  State<MainAppWithBottomNav> createState() => MainAppWithBottomNavState();
}

class MainAppWithBottomNavState extends State<MainAppWithBottomNav> {
  late PageController _pageController;
  final List<Widget> _pages = [
    MainMenuPage(),
    FavesPage(),
    AboutPage(),
    SearchPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: NavigationService.selectedIndex.value,
    );

    // Listen to navigation service changes and animate to page
    NavigationService.selectedIndex.addListener(_onNavigationChanged);
  }

  void _onNavigationChanged() {
    final newIndex = NavigationService.selectedIndex.value;
    if (_pageController.hasClients &&
        newIndex != _pageController.page?.round()) {
      _pageController.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    NavigationService.selectedIndex.removeListener(_onNavigationChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: NavigationService.selectedIndex,
      builder: (context, selectedIndex, child) {
        return Scaffold(
          body: SafeArea(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                // Update navigation service when user swipes
                NavigationService.navigateToIndex(index);
              },
              children: _pages,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              NavigationService.navigateToSearch(); // Navigate to SearchPage (index 3)
            },
            elevation: 0,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? (selectedIndex == 3
                      ? Colors.red.shade600
                      : const Color(0xFF2D2D2D))
                : (selectedIndex == 3
                      ? Colors.red.shade800
                      : const Color(0xFFFFFDF7)),
            foregroundColor: Colors.white,
            shape: CircleBorder(),
            child: Icon(Icons.search),
            //params
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            onTap: (index) => NavigationService.navigateToIndex(index),
            gapLocation: GapLocation.end,
            notchSmoothness: NotchSmoothness.softEdge,
            activeColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.red.shade400
                : Colors.red.shade900,
            inactiveColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade500
                : Colors.grey.shade600,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF2D2D2D)
                : const Color(0xFFFFFDF7),
            iconSize: 24,
            icons: [Icons.home, Icons.favorite, Icons.info],
            activeIndex: selectedIndex,
          ),
        );
      },
    );
  }
}

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainMenu();
  }
}
