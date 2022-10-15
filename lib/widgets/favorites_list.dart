import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/controllers/faves_controller.dart';
import 'package:zipcodeph_flutter/screens/search_screen.dart';
import 'package:zipcodeph_flutter/widgets/not_found.dart';
import 'package:zipcodeph_flutter/widgets/zipcode_tile.dart';

import '../models/zipcode.dart';

class FavoritesList extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  FavoritesList({Key? key}) : super(key: key);

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  void _refreshList() {
    setState(() {});
  }

  final FavoritesController _favoritesController = FavoritesController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ZipCode>?>(
      future: _favoritesController.getFaves(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text("Error loading favorite ZIP codes."),
          );
        } else {
          final List<ZipCode> list = snapshot.data!;
          if (list.isEmpty) {
            return EmptyGraphics(
              image: const AssetImage("assets/images/empty.png"),
              promptText: "You have no favorites yet",
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
            );
          } else {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, index) => const Divider(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ZipCodeTile(
                  zipCode: list[index],
                  refreshListCallback: _refreshList,
                  isAreaSubtitleVisible: true,
                );
              },
            );
          }
        }
      },
    );
  }
}
