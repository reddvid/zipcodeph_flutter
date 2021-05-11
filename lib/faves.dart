import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        margin: MediaQuery.of(context).padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Specify a custom transition to be used for
            // animating between opened and closed stated.
          ],
        ),
      ),
    );
  }
}
