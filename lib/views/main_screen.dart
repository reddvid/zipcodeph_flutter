import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zipcodeph_flutter/views/quiz_screen.dart';
import 'package:zipcodeph_flutter/widgets/menu/group_menu_button.dart';
import '../main.dart';
import 'about_screen.dart';
import 'favorites_screen.dart';
import 'search_screen.dart';
import 'package:http/http.dart' as http;

class MainMenu extends StatefulWidget {
  final Logger logger;

  const MainMenu({super.key, required this.logger});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with RouteAware {
  late List<dynamic> triviaList = [];
  late String currentTrivia = "Loading content";
  bool triviaPop = false;
  double _height = 110;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });

    loadTriviaList();
  }

  Future<void> loadTriviaList() async {
    try {
      const endpoint = "https://api.npoint.io/25a6f8775d3cb3d8f24c/";
      widget.logger.i("Loading trivia list from $endpoint");

      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        widget.logger.i("Response ${response.statusCode}");
        widget.logger.i("Loading trivia");
        final jsonResult = jsonDecode(response.body)['trivias'];
        setState(() {
          triviaList = jsonResult;
          triviaList.shuffle();
          currentTrivia = triviaList.isEmpty ? "" : triviaList.first;
        });
      } else {
        widget.logger.e("HTTP response not valid ${response.statusCode}");
      }
    } on SocketException catch (e) {
      widget.logger.e(e.message);
      widget.logger.i("Reading local trivia");
      rootBundle.loadString("assets/json/trivias.json").then(
        (value) {
          final jsonResult = jsonDecode(value)['trivias'];
          setState(() {
            triviaList = jsonResult;
            triviaList.shuffle();
            currentTrivia = triviaList.isEmpty ? "" : triviaList.first;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 180 : 110;
    debugPrint(_height.toString());
    return Container(
      constraints: const BoxConstraints(minWidth: 800, maxWidth: 800),
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      padding: ResponsiveValue<EdgeInsets>(context,
          defaultValue: const EdgeInsets.symmetric(horizontal: 30.0),
          conditionalValues: [
            const Condition.smallerThan(
              name: TABLET,
              value: EdgeInsets.symmetric(horizontal: 0.0),
            ),
          ]).value,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ResponsiveVisibility(
                  visible: false,
                  hiddenConditions: const [Condition.largerThan(name: MOBILE)],
                  visibleConditions: const [Condition.between(start: 0, end: 800)],
                  child: aboutButton(),
                ),
                triviaContainer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    searchButton(),
                    favoritesButton(),
                  ],
                ),
                // LIST
                ResponsiveVisibility(
                  visibleConditions: const [
                    Condition.between(
                      start: 0,
                      end: 1200,
                    ),
                  ],
                  hiddenConditions: const [
                    Condition.between(
                      start: 1201,
                      end: 1920,
                    ),
                  ],
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GroupMenuButton(
                            title: 'Metro Manila',
                            backgroundImagePath: 'assets/images/ncr.jpg',
                            height: _height,
                          ),
                          const Divider(
                            height: 10,
                            color: Colors.transparent,
                          ),
                          GroupMenuButton(
                            title: 'Luzon',
                            backgroundImagePath: 'assets/images/luzon.jpg',
                            height: _height,
                          ),
                          const Divider(
                            height: 10,
                            color: Colors.transparent,
                          ),
                          GroupMenuButton(
                            title: 'Visayas',
                            backgroundImagePath: 'assets/images/visayas.jpg',
                            height: _height,
                          ),
                          const Divider(
                            height: 10,
                            color: Colors.transparent,
                          ),
                          GroupMenuButton(
                            title: 'Mindanao',
                            backgroundImagePath: 'assets/images/mindanao.jpg',
                            height: _height,
                          ),
                          const Divider(
                            height: 40,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // GRID
                ResponsiveVisibility(
                  visibleConditions: const [
                    Condition.between(start: 1201, end: 1920),
                  ],
                  hiddenConditions: const [
                    Condition.between(start: 0, end: 1200),
                  ],
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GroupMenuButton(
                              title: 'Metro Manila',
                              backgroundImagePath: 'assets/images/ncr.jpg',
                              height: _height,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: GroupMenuButton(
                              title: 'Luzon',
                              backgroundImagePath: 'assets/images/luzon.jpg',
                              height: _height,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GroupMenuButton(
                              title: 'Visayas',
                              backgroundImagePath: 'assets/images/visayas.jpg',
                              height: _height,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: GroupMenuButton(
                              title: 'Mindanao',
                              backgroundImagePath: 'assets/images/mindanao.jpg',
                              height: _height,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  alamin() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.yellow,
            Colors.red,
            Colors.blue,
          ],
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AlaminPage(),
            ),
          );
        },
        title: const Text("Test Your Knowledge"),
        subtitle: const Text("Learn Philippine history and general facts"),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  triviaContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
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
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Did You Know?',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          const Divider(
            height: 5,
            color: Colors.transparent,
          ),
          SizedBox(
            height: 40,
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    setState(() {
                      triviaPop = true;
                    });
                    // final result = await showDialogAlert(
                    //   context: context,
                    //   title: 'Did You Know?',
                    //   message: currentTrivia,
                    //   actionButtonTitle: 'SHARE',
                    //   cancelButtonTitle: 'CLOSE',
                    // );
                    // if (result == ButtonActionType.action) {
                    //   _shareTrivia(currentTrivia);
                    // }
                  },
                text: currentTrivia ?? "Failed to load content",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: shareButton(),
          )
        ],
      ),
    );
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
        label: const Text(
          'Share',
          style: TextStyle(fontSize: 12.0, color: Colors.white),
        ),
        onPressed: () {
          Clipboard.setData(
            ClipboardData(text: currentTrivia),
          );
          // var snackBar = const SnackBar(
          //   content: Text("Trivia copied for sharing"),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          _shareTrivia(currentTrivia);
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      ),
    );
  }

  aboutButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton.icon(
        icon: Icon(
          Platform.isAndroid ? Icons.info_outline : CupertinoIcons.info_circle,
        ),
        label: const Text('Help & About'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AboutPage(),
            ),
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      ),
    );
  }

  searchButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton.icon(
        icon: Icon(
          Platform.isAndroid ? Icons.search : CupertinoIcons.search,
        ),
        label: const Text(
          'Search ZIP Codes',
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(),
            ),
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      ),
    );
  }

  favoritesButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton.icon(
        icon: Icon(
          Platform.isAndroid ? Icons.favorite_outline : CupertinoIcons.heart,
        ),
        label: const Text('Favorites'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavesPage(),
            ),
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      ),
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
      height: 60,
      color: Colors.transparent,
    );
  }

  void _shareTrivia(String currentTrivia) {
    Share.share(
      "Did You Know? $currentTrivia #ZIPCodePH",
      subject: "Did You Know? ZIP Code PH Trivia",
    );
  }
}
