import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zipcodeph_flutter/controllers/search.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);
  final SearchController _searchController = SearchController();

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void _refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
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

  List<ListTile> _createList(List<ZipCode> zipcodes) {
    return zipcodes
        .map((zip) => ListTile(
              leading: Text(zip.code.toString()),
              title: Text(zip.town),
            ))
        .toList();
  }
}
