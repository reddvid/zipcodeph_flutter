import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/constants.dart';
import 'package:zipcodeph_flutter/main.dart';
import 'package:zipcodeph_flutter/screens/about_screen.dart';
import 'package:zipcodeph_flutter/screens/cities_screen.dart';
import 'package:zipcodeph_flutter/screens/favorites_screen.dart';
import 'package:zipcodeph_flutter/screens/search_screen.dart';
import 'package:zipcodeph_flutter/widgets/area_menu_button.dart';
import 'package:zipcodeph_flutter/widgets/icon_button.dart';

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
              trivia(),
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
                          builder: (context) => SearchPage(),
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
                      const Divider(
                        height: 80.0,
                      ),
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

  trivia() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Did You Know?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
            Divider(
              height: 5,
              color: Colors.transparent,
            ),
            Text('Text', style: TextStyle(color: Colors.white))
            // Align(
            //     alignment: Alignment.bottomRight,
            //     child: shareButton())
          ],
        ),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            )));
  }

  shareButton() {
    return ElevatedButton.icon(
      icon: Icon(
        Platform.isAndroid ? Icons.share : CupertinoIcons.share,
        size: 12.0,
      ),
      label: const Text('Share', style: TextStyle(fontSize: 12.0)),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          primary: Colors.black.withOpacity(0.0),
          shadowColor: Colors.transparent),
    );
  }

  aboutButton() {
    return Align(
        alignment: Alignment.topRight,
        child: TextButton.icon(
            icon: Icon(
                Platform.isAndroid
                    ? Icons.info_outline
                    : CupertinoIcons.info_circle,
                color: Colors.black),
            label: const Text('Help & About',
                style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )))));
  }

  searchButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextButton.icon(
            icon: Icon(
                Platform.isAndroid ? Icons.search : CupertinoIcons.search,
                color: Colors.black),
            label: const Text('Search ZIP Codes',
                style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )))));
  }

  favoritesButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextButton.icon(
            icon: Icon(
                Platform.isAndroid
                    ? Icons.favorite_outline
                    : CupertinoIcons.heart,
                color: Colors.black),
            label:
                const Text('Favorites', style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()));
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )))));
  }

  ncr() {
    return Stack(
      children: [
        bgImage('assets/images/ncr.jpg'),
        ClipRRect(
          // Clip it cleanly.
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              alignment: Alignment.center,
              child: menuTitle('Metro Manila'),
            ),
          ),
        ),
      ],
    );
  }

  luzon() {
    return Stack(
      children: [
        bgImage('assets/images/luzon.jpg'),
        ClipRRect(
            // Clip it cleanly.
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            alignment: Alignment.center,
            child: menuTitle('Luzon'),
          ),
        )),
      ],
    );
  }

  visayas() {
    return Stack(
      children: [
        bgImage('assets/images/visayas.jpg'),
        ClipRRect(
          // Clip it cleanly.
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              alignment: Alignment.center,
              child: menuTitle('Visayas'),
            ),
          ),
        ),
      ],
    );
  }

  mindanao() {
    return Stack(
      children: [
        bgImage('assets/images/mindanao.jpg'),
        ClipRRect(
          // Clip it cleanly.
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              alignment: Alignment.center,
              child: menuTitle('Mindanao'),
            ),
          ),
        ),
      ],
    );
  }

  divider() {
    return const Divider(
      height: 10,
      color: Colors.transparent,
    );
  }

  enddivider() {
    return const Divider(
      height: 40,
      color: Colors.transparent,
    );
  }

  bgImage(String imgPath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        image: DecorationImage(
          image: AssetImage(imgPath),
          fit: BoxFit.fitWidth,
        ),
      ),
      width: double.infinity,
      height: _height,
    );
  }

  menuTitle(String title) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AreasPage(area: title)));
        },
        child: SizedBox(
            width: double.infinity,
            height: _height,
            child: Center(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)))),
      ),
    );
  }
}

// Future<void> openUrl(String url) async {
//   if (await canLaunch(url)) {
//     await launch(
//       url,
//       forceSafariVC: false,
//       forceWebView: false,
//     );
//   }
// }
