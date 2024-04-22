import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Search"),
      actions: [searchBar],
    );
  }

  _SearchPageState() {
    searchBar = SearchBar(
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
      appBar: AppBar(actions: [searchBar]),
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
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 80),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              ZipCode zipCode = snapshot.data![index];
              return ListTile(
                  onLongPress: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return bottomSheet(
                              context, snapshot.data![index], _refreshList);
                        });
                  },
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return bottomSheet(
                              context, snapshot.data![index], _refreshList);
                        });
                  },
                  visualDensity: const VisualDensity(vertical: -4),
                  // to compact
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
        } else {
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/images/notfound.png',
                width: MediaQuery.of(context).size.width * 0.6,
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
                  ))
            ]),
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
