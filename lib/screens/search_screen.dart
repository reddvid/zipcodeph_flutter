import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zipcodeph_flutter/controllers/search_controller.dart';
import 'package:zipcodeph_flutter/main.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/services/url_launcher.dart';
import 'package:zipcodeph_flutter/widgets/not_found.dart';
import 'package:zipcodeph_flutter/widgets/zipcode_tile.dart';

import '../widgets/search_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBar searchBar;
  String query = "";

  @override
  void initState() {
    super.initState();
    createSearchBar();
  }

  void createSearchBar() {
    searchBar = SearchBar(
      inBar: false,
      hintText: "Search towns, cities, or province",
      setState: setState,
      onChanged: (value) {
        setState(() {
          query = value;
        });
      },
      onCleared: () {
        setState(() {
          query = "";
        });
      },
      onClosed: () {
        setState(() {
          query = "";
        });
      },
      closeOnSubmit: false,
      clearOnSubmit: false,
      showClearButton: true,
      buildDefaultAppBar: (context) => AppBar(
        title: const Text("Search"),
        actions: [
          searchBar.getSearchAction(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: SearchList(query: query),
    );
  }
}
