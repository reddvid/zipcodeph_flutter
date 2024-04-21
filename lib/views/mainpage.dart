import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zipcodeph_flutter2/views/alaminpage.dart';
import '../main.dart';
import '../views/aboutpage.dart';
import '../views/areaspage.dart';
import '../views/favespage.dart';
import '../views/searchpage.dart';
import 'package:http/http.dart' as http;

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
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });

    loadTrivias();
  }

  void loadTrivias() async {
    try {
      final response = await http
          .get(Uri.parse("https://api.npoint.io/25a6f8775d3cb3d8f24c/"));
      // debugPrint(response.body);

      if (response.statusCode == 200) {
        // Connected
        debugPrint("Getting trivias online");
        final jsonResult = jsonDecode(response.body)['trivias'];
        setState(() {
          trivias = jsonResult;
          trivias.shuffle();
          currentTrivia = trivias.isEmpty ? "" : trivias.first;
        });
      }
    } on SocketException catch (e) {
      // Not Connected
      debugPrint("Reading local trivias\n${e.message}");
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ResponsiveVisibility(
                visible: false,
                hiddenConditions: const [Condition.largerThan(name: MOBILE)],
                child: aboutButton(),
              ),
              trivia(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  searchButton(),
                  favoritesButton(),
                ],
              ),
              ResponsiveVisibility(
                visible: false,
                hiddenConditions: const [Condition.largerThan(name: MOBILE)],
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ncr(),
                        divider(),
                        luzon(),
                        divider(),
                        visayas(40.0),
                        divider(),
                        mindanao(),
                        divider(),
                        divider(),
                        alamin(),
                        enddivider()
                      ],
                    ),
                  ),
                ),
              ),
              ResponsiveVisibility(
                visible: true,
                visibleConditions: const [Condition.largerThan(name: MOBILE)],
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ncr(),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: luzon(),
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
                          child: visayas(40.0),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: mindanao(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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

  trivia() {
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
          RichText(
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
              text: currentTrivia,
              style: const TextStyle(color: Colors.white),
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

  ncr() {
    return Stack(
      children: [
        bgImage('assets/images/ncr.jpg'),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
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
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              alignment: Alignment.center,
              child: menuTitle('Luzon'),
            ),
          ),
        ),
      ],
    );
  }

  visayas(double? height) {
    return Stack(
      children: [
        bgImage('assets/images/visayas.jpg'),
        ClipRRect(
          // Clip it cleanly.
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              height: height ?? 40.0,
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
          borderRadius: BorderRadius.circular(10),
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
      height: 60,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AreasPage(area: title),
            ),
          );
        },
        child: SizedBox(
          width: double.infinity,
          height: _height,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _shareTrivia(String currentTrivia) {
    Share.share(
      "Did You Know? $currentTrivia #ZIPCodePH",
      subject: "Did You Know? ZIP Code PH Trivia",
    );
  }
}
