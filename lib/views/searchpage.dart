import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:zipcodeph_flutter/controllers/search.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/views/mainpage.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);
  final SearchController _searchController = SearchController();

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _editingController = TextEditingController();
  late SearchBar searchBar;
  late String query = "";
  void _refreshList() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _editingController.addListener(() {
      final String text = _editingController.text;
    });
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
        controller: _editingController,
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
        buildDefaultAppBar: buildAppBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: _List(widget._searchController, query, _refreshList),
    );
  }
}

class _List extends StatelessWidget {
  final SearchController _searchController;
  final String _query;
  final VoidCallback _refreshList;

  const _List(this._searchController, this._query, this._refreshList);

  @override
  Widget build(BuildContext context) {
    void _showPopupMenu(Offset offset) async {
      double left = offset.dx;
      double top = offset.dy;
      await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(left, top, 0, 0),
        items: [
          const PopupMenuItem<String>(child: Text('Doge'), value: 'Doge'),
          const PopupMenuItem<String>(child: Text('Lion'), value: 'Lion'),
        ],
        elevation: 8.0,
      );
    }

    print(_query);
    return FutureBuilder<List<ZipCode>>(
        future: _searchController.findCodes(_query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("Search Placeholder..."));
          } else {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ZipCode zipCode = snapshot.data![index];
                return ListTile(
                    onLongPress: () {
                      _showPopupMenu(Offset.zero);
                    },
                    trailing: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          _showPopupMenu(details.globalPosition);
                        },
                        child: const Icon(Icons.more_vert)),
                    visualDensity:
                        const VisualDensity(vertical: -4), // to compact
                    leading: Container(
                        width: 48,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          zipCode.code.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                    subtitle: Text(zipCode.area),
                    title: Text(zipCode.town));
              },
            );
          }
        });
  }
}
