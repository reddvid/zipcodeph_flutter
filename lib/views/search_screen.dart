import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../controllers/search_controller.dart';
import '../services/url_launcher.dart';
import '../widgets/not_found.dart';
import '../widgets/zipcode_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBar searchBar;
  late AnimSearchBar aSearchBar;
  String query = "";
  final textController = TextEditingController();
  final _searchController = SearchZipsController();
  bool isSearchOpen = true;

  void _refreshList() {
    setState(() {});
  }

  _SearchPageState() {
    searchBar = SearchBar(
      elevation: MaterialStateProperty.all(2),
      controller: textController,
      constraints: const BoxConstraints(
        maxWidth: double.maxFinite,
        minHeight: 40,
        maxHeight: 48,
      ),
      autoFocus: true,
      hintText: "Search towns, cities, or province",
      onChanged: (value) {
        setState(() {
          query = value;
          textController.text = value;
        });
      },
      // leading: const Icon(Icons.arrow_back_outlined),
      trailing: [
        Visibility(
          child: Ink(
            decoration: const ShapeDecoration(
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.clear,
                size: 16.0,
              ),
              onPressed: () {
                setState(() {
                  textController.text = '';
                  query = '';
                  isSearchOpen = false;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    late double width = MediaQuery.of(context).size.width;
    if (kDebugMode) {
      print("width $width");
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        actions: [
          Visibility(
            visible: isSearchOpen,
            child: Padding(
              padding: width > 800
                  ? const EdgeInsets.only(right: 20)
                  : const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                constraints: width > 800
                    ? const BoxConstraints(maxWidth: 480)
                    : BoxConstraints(maxWidth: width - 40.0),
                child: searchBar,
              ),
            ),
          ),
          Visibility(
            visible: !isSearchOpen,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isSearchOpen = true;
                });
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
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
