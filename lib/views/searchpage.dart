import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:zipcodeph_flutter/controllers/search.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);
  final SearchController _searchController = SearchController();

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBar searchBar;

  void _refreshList() {
    setState(() {});
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Search"),
      actions: [searchBar.getSearchAction(context)],
    );
  }

  _SearchPageState() {
    searchBar = SearchBar(
        inBar: false,
        hintText: "Search towns, cities, or province",
        setState: setState,
        closeOnSubmit: false,
        clearOnSubmit: false,
        showClearButton: true,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: _List(widget._searchController, _refreshList),
    );
  }
}

class _List extends StatelessWidget {
  final SearchController _searchController;
  final VoidCallback _refreshList;

  const _List(this._searchController, this._refreshList);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ZipCode>>(
        future: _searchController.getAllCodes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("Search Placeholder..."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ZipCode zipCode = snapshot.data![index];
                return Text(zipCode.code.toString() + " " + zipCode.town);
              },
            );
          }
        });
  }
}
