import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/views/search_screen.dart';

import '../controllers/faves_controller.dart';
import '../widgets/not_found.dart';
import '../widgets/zipcode_list.dart';

class FavoritesPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  void _refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoritesController = FavoritesController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        actions: [
          IconButton(
            tooltip: "Add",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              ).then((value) {
                setState(() {});
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ZipCodesList(
        future: favoritesController.getFaves(),
        refreshCallback: () => _refreshList(),
        errorText: "Error loading favorite ZIP codes.",
        showSubtitle: true,
        emptyGraphics: EmptyGraphics(
          image: const AssetImage("assets/images/empty.png"),
          promptText: "You have no favorites yet 💔",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            ).then((value) {
              _refreshList();
            });
          },
          buttonLabel: "Search ZIP Codes",
        ),
      ),
    );
  }
}
