import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  static const double _height = 130;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          margin: MediaQuery.of(context).padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              aboutButton(),
              Container(
                  width: double.infinity,
                  height: 110,
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Did You Know?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                      trivia(),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: shareButton())
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
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [searchButton(), favoritesButton()],
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    ncr(),
                    const Spacer(),
                    luzon(),
                    const Spacer(),
                    visayas(),
                    const Spacer(),
                    mindanao()
                  ],
                ),
              ))
            ],
          )),
    ));
  }

  trivia() {
    return const Text('Text', style: TextStyle(color: Colors.white));
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
    return ElevatedButton.icon(
      icon: Icon(
          Platform.isAndroid ? Icons.info_outline : CupertinoIcons.info_circle,
          color: Colors.black),
      label: const Text('Help & About', style: TextStyle(color: Colors.black)),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          primary: Colors.black.withOpacity(0.0),
          shadowColor: Colors.transparent),
    );
  }

  searchButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ElevatedButton.icon(
          icon: Icon(Platform.isAndroid ? Icons.search : CupertinoIcons.search,
              color: Colors.black),
          label: const Text('Search ZIP Codes',
              style: TextStyle(color: Colors.black)),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              primary: Colors.black.withOpacity(0.0),
              shadowColor: Colors.transparent),
        ));
  }

  favoritesButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ElevatedButton.icon(
          icon: Icon(
              Platform.isAndroid ? Icons.star_outline : CupertinoIcons.heart,
              color: Colors.black),
          label: const Text('Favorites', style: TextStyle(color: Colors.black)),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              primary: Colors.black.withOpacity(0.0),
              shadowColor: Colors.transparent),
        ));
  }

  ncr() {
    return Stack(
      children: [bgImage('assets/images/ncr.jpg'), menuTitle('Metro Manila')],
    );
  }

  luzon() {
    return Stack(
      children: [bgImage('assets/images/ncr.jpg'), menuTitle('Luzon')],
    );
  }

  visayas() {
    return Stack(
      children: [bgImage('assets/images/ncr.jpg'), menuTitle('Visayas')],
    );
  }

  mindanao() {
    return Stack(
      children: [bgImage('assets/images/ncr.jpg'), menuTitle('Mindanao')],
    );
  }

  divider() {
    return const Divider(
      height: 10,
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
          fit: BoxFit.cover,
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
        onTap: () {},
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

Future<void> openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  }
}
