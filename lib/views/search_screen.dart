import 'dart:async';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:zipcodeph_flutter/controllers/search_controller.dart' as custom;
import 'package:zipcodeph_flutter/services/url_launcher.dart';
import 'package:zipcodeph_flutter/widgets/not_found.dart';
import 'package:zipcodeph_flutter/widgets/zipcode_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();
  String query = "";
  Timer? _debounceTimer;

  final custom.SearchController _searchController = custom.SearchController();

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _textController.dispose();
    super.dispose();
  }

  void _refreshList() {
    setState(() {});
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        query = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            hintText: "Search towns, cities, or province",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: _onSearchChanged,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          if (_textController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _textController.clear();
                setState(() {
                  query = "";
                });
              },
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
              "mailto:hi@reddavid.me?subject=[FEEDBACK] ZIP Code PH&body=App version: ${appInfo.version} build ${appInfo.buildNumber}\n",
            );
          },
          buttonLabel: "Send feedback",
        ),
      ),
    );
  }
}
