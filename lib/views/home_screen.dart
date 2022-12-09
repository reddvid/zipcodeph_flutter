import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/views/login_screen.dart';
import 'package:zipcodeph_flutter/widgets/area_menu_button.dart';

import '../constants.dart';
import '../widgets/trivia_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

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
                child: user != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(user!.photoURL!),
                      )
                    : const Icon(Icons.account_circle_outlined),
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
