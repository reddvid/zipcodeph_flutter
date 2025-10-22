import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/widgets/area_menu_button.dart';

import '../constants.dart';
import '../widgets/trivia_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TriviaBox(),
          const SizedBox(height: 20.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (AreaMenuButton button in menuButtons) button,
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
