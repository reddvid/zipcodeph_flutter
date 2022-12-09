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
  String _buildGreeting(DateTime currentTime) {
    debugPrint("Time" + currentTime.hour.toString());

    if (FirebaseAuth.instance.currentUser != null) {
      if (currentTime.hour >= 4 && currentTime.hour < 12) {
        return "Good morning, ";
      } else if (currentTime.hour >= 12 && currentTime.hour <= 17) {
        return "Good afternoon, ";
      } else {
        return "Good evening, ";
      }
    } else {
      return "Hello!";
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final currentTime = DateTime.now();
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
                children: [
                  const Text(
                    "FRI, DEC 9",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    user == null
                        ? "Hello!"
                        : _buildGreeting(currentTime) +
                            user!.displayName!.split(' ')[0].toString(),
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade,
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
