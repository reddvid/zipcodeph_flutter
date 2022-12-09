import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/views/login_screen.dart';
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
        left: 20.0,
        right: 20.0,
        top: 30.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("FRI, DEC 9"),
                  Text(
                    "Hello!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                child: const CircleAvatar(),
                onTap: () {
                  // TODO: Open Login Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TriviaBox(),
          const SizedBox(height: 20.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (AreaMenuButton button in menuButtons) button,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
