import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zipcodeph_flutter/main.dart';
import 'package:zipcodeph_flutter/views/aboutpage.dart';
import 'package:zipcodeph_flutter/views/areaspage.dart';
import 'package:zipcodeph_flutter/views/favespage.dart';
import 'package:zipcodeph_flutter/views/searchpage.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with RouteAware {
  late List<dynamic> trivias = [];
  late String currentTrivia = "";
  bool triviaPop = false;
  double _height = 110;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    DefaultAssetBundle.of(context)
        .loadString("assets/json/trivias.json")
        .then((value) {
      final jsonResult = jsonDecode(value)['trivias'];
      setState(() {
        trivias = jsonResult;
        trivias.shuffle();
        currentTrivia = trivias.isEmpty ? "" : trivias.first;
      });
    });
    super.initState();
  }

  @override
  void didPopNext() {
    if (!triviaPop) {
      setState(() {
        trivias.shuffle();
        currentTrivia = trivias.first;
      });
    }
    triviaPop = false;
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              aboutButton(),
              trivia(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [searchButton(), favoritesButton()],
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  ncr(),
                  divider(),
                  luzon(),
                  divider(),
                  visayas(),
                  divider(),
                  mindanao(),
                  divider(),
                  enddivider()
                ],
              ))),
            ],
          )),
    ));
  }

  trivia() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Did You Know?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
            const Divider(
              height: 5,
              color: Colors.transparent,
            ),
            RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        setState(() {
                          triviaPop = true;
                        });
                        final result = await showDialogAlert(
                          context: context,
                          title: 'Did You Know',
                          message: currentTrivia,
                          actionButtonTitle: 'Share',
                          cancelButtonTitle: 'Close',
                        );
                        if (result == ButtonActionType.action) {
                          _shareTrivia(currentTrivia);
                        }
                      },
                    text: currentTrivia,
                    style: const TextStyle(color: Colors.white))),
            Align(alignment: Alignment.bottomRight, child: shareButton())
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
    return SizedBox(
        height: 35,
        child: TextButton.icon(
            icon: Icon(
              Platform.isAndroid ? Icons.share : CupertinoIcons.share,
              size: 12.0,
              color: Colors.white,
            ),
            label: const Text('Share',
                style: TextStyle(fontSize: 12.0, color: Colors.white)),
            onPressed: () {
              _shareTrivia(currentTrivia);
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )))));
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
                  MaterialPageRoute(builder: (context) => FavesPage()));
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
    _height = MediaQuery.of(context).size.height * 0.5 * 0.25;
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

  void _shareTrivia(String currentTrivia) {
    Share.share(currentTrivia + " #ZIPCodePH",
        subject: "Did You Know? ZIP Code PH Trivia");
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
