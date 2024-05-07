import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart' as sb;
import 'package:package_info_plus/package_info_plus.dart';

import '../controllers/search_controller.dart';
import '../services/url_launcher.dart';
import '../widgets/not_found.dart';
import '../widgets/zipcode_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late sb.SearchBar searchBar;
  String query = "";

  final _searchController = SearchZipsController();

  @override
  void initState() {
    super.initState();
    createSearchBar();
  }

  void _refreshList() {
    setState(() {});
  }

  void createSearchBar() {
    searchBar = sb.SearchBar(
      inBar: true,
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
      body: ZipCodesList(
        refreshCallback: () => _refreshList(),
        future: _searchController.findCodes(query),
        errorText: "Error loading ZIP codes.",
        showSubtitle: true,
        showTrailing: true,
        emptyGraphics: EmptyGraphics(
          image: const AssetImage("assets/images/notfound.png"),
          promptText: "No results for '$query'",
          onPressed: () async {
            final appInfo = await PackageInfo.fromPlatform();
            UrlLauncher.openUrl(
                "mailto:hi@reddavid.me?subject=[FEEDBACK] ZIP Code PH&body=App version: ${appInfo.version} build ${appInfo.buildNumber}\n");
          },
          buttonLabel: "Send feedback",
        ),
      ),
    );
  }
}
