import 'package:flutter/material.dart';
import 'views/about_screen.dart';
import 'views/favorites_screen.dart';
import 'views/home_screen.dart';
import 'views/search_screen.dart';
import 'widgets/area_menu_button.dart';

const kTileVisualDensity = VisualDensity(vertical: -4.0);
const kTileLeadingTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

const kSnackBarMargin = EdgeInsets.only(
  left: 8.0,
  right: 8.0,
  bottom: 64.0,
);

const kAppBarTitleStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

const List<AreaMenuButton> menuButtons = [
  AreaMenuButton(
    bgImage: AssetImage("assets/images/ncr.jpg"),
    label: "Metro Manila",
  ),
  AreaMenuButton(
    bgImage: AssetImage("assets/images/luzon.jpg"),
    label: "Luzon",
  ),
  AreaMenuButton(
    bgImage: AssetImage("assets/images/visayas.jpg"),
    label: "Visayas",
  ),
  AreaMenuButton(
    bgImage: AssetImage("assets/images/mindanao.jpg"),
    label: "Mindanao",
  ),
];

const List<Widget> pages = [
  HomeScreen(),
  SearchPage(),
  FavoritesPage(),
  AboutPage()
];

const List<String> sampleFormatText = [
  "Mr. Juan Dela Cruz",
  "Malacañan Complex",
  "J.P. Laurel Street",
  "1005 San Miguel, Manila",
];

const List<Set<String>> kAttributions = [
  {
    "Makati City during Night by Sean Yoro",
    "https://unsplash.com/@seanyoro?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText",
  },
  {
    "Mayon Volcano by Camille San Vicente",
    "https://unsplash.com/es/@camillesanvicente?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText",
  },
  {
    "Bohol Chocolate Hills by Robin P",
    "https://unsplash.com/@rob1p?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText",
  },
  {
    "Kawhagan Island by Alejandro Luengo",
    "https://unsplash.com/es/@aluengo91?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText",
  },
];
