import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zipcodeph_flutter/widgets/zipcode_tile.dart';
import '../controllers/search_controller.dart';
import '../main.dart';
import '../models/zipcode.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  final CustomSearchController _searchController = CustomSearchController();

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with RouteAware {
  late SearchBar searchBar;
  late AnimSearchBar newSearchBar;
  late String query = "";

  void _refreshList() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
  }

  _SearchPageState() {
    searchBar = SearchBar(
      elevation: MaterialStateProperty.all(2),
      constraints: const BoxConstraints(
        maxWidth: 480,
        minWidth: 320,
        minHeight: 40,
        maxHeight: 48,
      ),
      autoFocus: true,
      hintText: "Search towns, cities, or province",
      onChanged: (value) {
        setState(() {
          query = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: searchBar,
          )
        ],
        title: const Text('Search'),
      ),
      body: _List(
        widget._searchController,
        query,
        _refreshList,
      ),
    );
  }
}

class _List extends StatelessWidget {
  final CustomSearchController _searchController;
  final String _query;
  final VoidCallback _refreshList;

  const _List(this._searchController, this._query, this._refreshList);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ZipCode>?>(
      future: _searchController.findCodes(_query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(minWidth: 800, maxWidth: 800),
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 80),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  ZipCode zipCode = snapshot.data![index];
                  return ZipCodeTile(
                    zipCode: zipCode,
                    refreshListCallback: null,
                    showSubtitle: true,
                  );
                },
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/notfound.png',
                    width: MediaQuery.of(context).size.width > 800
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
                Text(
                  "Found nothing for '$_query'",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () async {
                    final info = await PackageInfo.fromPlatform();
                    _launchUrl(
                        "mailto:reddavidapps?subject=[FEEDBACK] ZIP Code PH&body=App version: ${info.version} build ${info.buildNumber}");
                  },
                  child: const Text(
                    "SEND FEEDBACK",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  bottomSheet(BuildContext context, ZipCode zipCode, VoidCallback refreshList) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "${zipCode.code} ${zipCode.town}, ${zipCode.area}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text("Copy"),
            onTap: () {
              Clipboard.setData(ClipboardData(
                  text: "${zipCode.code} ${zipCode.town}, ${zipCode.area}"));
              Navigator.pop(context);
              var snackBar = SnackBar(
                content: Text(
                    "Copied ${zipCode.code} ${zipCode.town}, ${zipCode.area}"),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          zipCode.fave == 1
              ? ListTile(
                  leading: const Icon(Icons.heart_broken_outlined),
                  title: const Text("Remove from favorites"),
                  onTap: () {
                    zipCode.fave = 0;
                    _searchController.updateItem(zipCode);
                    refreshList();
                    Navigator.pop(context);
                    var snackBar = SnackBar(
                      content: Text(
                          "Removed ${zipCode.code} ${zipCode.town}, ${zipCode.area} from favorites"),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          zipCode.fave = 1;
                          _searchController.updateItem(zipCode);
                          refreshList();
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                )
              : ListTile(
                  leading: const Icon(Icons.favorite_border),
                  title: const Text("Add to favorites"),
                  onTap: () {
                    zipCode.fave = 1;
                    _searchController.updateItem(zipCode);
                    refreshList();
                    Navigator.pop(context);
                    var snackBar = SnackBar(
                      content: Text(
                          "Added ${zipCode.code} ${zipCode.town}, ${zipCode.area} to favorites"),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          zipCode.fave = 0;
                          _searchController.updateItem(zipCode);
                          refreshList();
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
          ListTile(
            leading: const Icon(Icons.map_outlined),
            title: const Text("Open in Maps"),
            onTap: () {
              _launchUrl(
                  "https://google.com/maps/search/${zipCode.town}, ${zipCode.area}");
              Navigator.pop(context);
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text("Cancel"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}
