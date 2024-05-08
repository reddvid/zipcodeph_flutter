import 'package:flutter/material.dart';

import '../constants.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenu> {
  final _pages = pages;
  int _selectedIndex = 0;
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Navigator(
          key: navigatorKeys[_selectedIndex],
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (_) => _pages.elementAt(_selectedIndex),
              maintainState: true,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showUnselectedLabels: false,
        backgroundColor:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? const Color.fromRGBO(235, 235, 235, 1)
                : const Color.fromRGBO(17, 17, 17, 1),
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            activeIcon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Favorites",
            activeIcon: Icon(Icons.favorite_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: "About",
            activeIcon: Icon(Icons.info),
          ),
        ],
      ),
    );
  }
}
