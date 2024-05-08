import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../constants.dart';
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
        if (value.trim() != "") {
          setState(() {
            query = value;
            textController.text = value;
          });
        }
      },
      // leading: const Icon(Icons.arrow_back_outlined),
      // trailing: [
      //   Visibility(
      //     child: Ink(
      //       decoration: const ShapeDecoration(
      //         shape: CircleBorder(),
      //       ),
      //       child: IconButton(
      //         icon: const Icon(
      //           Icons.clear,
      //           size: 16.0,
      //         ),
      //         onPressed: () {
      //           setState(() {
      //             textController.text = '';
      //             query = '';
      //             isSearchOpen = false;
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // ],
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
        title: Text(
          "Search".toUpperCase(),
          style: kAppBarTitleStyle,
        ),
        actions: [
          Visibility(
            visible: isSearchOpen,
            child: Padding(
              padding: width > 800
                  ? const EdgeInsets.only(right: 24.0)
                  : const EdgeInsets.only(left: 16.0),
              child: Container(
                constraints: width > 800
                    ? const BoxConstraints(maxWidth: 480)
                    : BoxConstraints(maxWidth: width - 64.0),
                child: searchBar,
              ),
            ),
          ),
          Visibility(
            visible: !isSearchOpen,
            child: IconButton(
              onPressed: () {
                setState(() {
                  textController.text = '';
                  query = '';
                  isSearchOpen = true;
                });
              },
              icon: const Icon(Icons.search),
            ),
          ),
          Visibility(
            visible: isSearchOpen,
            child: IconButton(
              onPressed: () {
                setState(() {
                  textController.text = '';
                  query = '';
                  isSearchOpen = false;
                });
              },
              icon: const Icon(Icons.close),
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
