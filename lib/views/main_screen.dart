import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/constants.dart';
import 'package:zipcodeph_flutter/views/about_screen.dart';
import 'package:zipcodeph_flutter/views/favorites_screen.dart';
import 'package:zipcodeph_flutter/views/search_screen.dart';
import 'package:zipcodeph_flutter/widgets/icon_button.dart';

import '../widgets/trivia_box.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  static const double _height = 110;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ActionIconButton(
                  icon: Icon(
                    Platform.isAndroid
                        ? Icons.info_outline
                        : CupertinoIcons.info_circle,
                  ),
                  label: "Help & About",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutPage(),
                      ),
                    );
                  },
                ),
              ),
              TriviaBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionIconButton(
                    icon: Icon(
                      Platform.isAndroid ? Icons.search : CupertinoIcons.search,
                    ),
                    label: "Search ZIP Codes",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                    },
                  ),
                  ActionIconButton(
                    icon: Icon(
                      Platform.isAndroid
                          ? Icons.favorite_outline
                          : CupertinoIcons.heart,
                    ),
                    label: "Favorites",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoritesPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var button in menuButtons) button,
                      const Divider(height: 80.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
