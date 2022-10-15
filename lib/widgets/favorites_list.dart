import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/controllers/faves_controller.dart';
import 'package:zipcodeph_flutter/controllers/zips_controller.dart';
import 'package:zipcodeph_flutter/widgets/zipcode_tile.dart';

import '../models/zipcode.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({
    Key? key,
  }) : super(key: key);

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
      future: _favoritesController.getAreaCodes(widget.city),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text("Error loading ZIP codes."),
          );
        } else {
          final List<ZipCode> list = snapshot.data!;
          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, index) => const Divider(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ZipCodeTile(
                zipCode: list[index],
                refreshListCallback: _refreshList,
              );
            },
          );
        }
      },
    );
  }
}
