import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:zipcodeph_flutter/views/main_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const MainMenu()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const kBodyStyle = TextStyle(fontSize: 20.0);
    const kPageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
      bodyTextStyle: kBodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      imageAlignment: Alignment.topCenter,
      bodyAlignment: Alignment.center,
    );

    Widget _buildImage(String assetName, [double width = 350]) {
      return Image.asset("assets/$assetName", width: width);
    }

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              right: 16.0,
            ),
            child: _buildImage("flutter.png", 100.0),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: ElevatedButton(
          child: const Text(
            "Skip?",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Find 🇵🇭 ZIP Codes",
          body:
              "Never worry again when filling out forms, sending mail or parcels.",
          decoration: kPageDecoration,
        ),
        PageViewModel(
          title: "Learn more about 🇵🇭",
          body: "Bite-sized trivias about the country to boost your knowledge.",
          decoration: kPageDecoration,
        ),
        PageViewModel(
          title: "Take it with You",
          body: "Use the app anywhere and anytime - even without internet.",
          decoration: kPageDecoration,
        ),
        PageViewModel(
          title: "Backup & Sync Favorites",
          body: "Bite-sized trivias about the country to boost your knowledge.",
          decoration: kPageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      back: const Icon(Icons.arrow_back),
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("LET'S GO"),
      showDoneButton: true,
      showBackButton: true,
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFAEAEAE),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24.0),
          ),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
