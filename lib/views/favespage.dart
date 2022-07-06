import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavesPage extends StatefulWidget {
  const FavesPage({Key? key}) : super(key: key);

  @override
  State<FavesPage> createState() => _FavesPageState();
}

class _FavesPageState extends State<FavesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Faves")),
      body: const Center(child: Text("Faves Page placeholder")),
    );
  }
}
