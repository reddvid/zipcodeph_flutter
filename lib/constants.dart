import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/widgets/area_menu_button.dart';

const kTileVisualDensity = VisualDensity(vertical: -4.0);
const kTileLeadingTextStyle = TextStyle(
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
