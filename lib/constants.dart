import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/widgets/area_menu_button.dart';

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
