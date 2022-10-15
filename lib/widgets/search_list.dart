import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:zipcodeph_flutter/controllers/search_controller.dart';
import 'package:zipcodeph_flutter/services/url_launcher.dart';
import 'package:zipcodeph_flutter/widgets/not_found.dart';
import 'package:zipcodeph_flutter/widgets/zipcode_tile.dart';

import '../models/zipcode.dart';

class SearchList extends StatefulWidget {
  const SearchList({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  void _refreshList() {
    setState(() {});
  }

  final SearchController _searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ZipCode>?>(
      future: _searchController.findCodes(widget.query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text("Error loading ZIP codes."),
          );
        } else {
          final List<ZipCode> list = snapshot.data!;
          if (list.isEmpty) {
            return EmptyGraphics(
              image: const AssetImage("assets/images/notfound.png"),
              promptText: "No results for '${widget.query}'",
              onPressed: () async {
                final appInfo = await PackageInfo.fromPlatform();
                UrlLauncher.openUrl(
                    "mailto:hi@reddavid.me?subject=[FEEDBACK] ZIP Code PH&body=App version: ${appInfo.version} build ${appInfo.buildNumber}\n");
              },
              buttonLabel: "Send feedback",
            );
          } else {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, index) => const Divider(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ZipCodeTile(
                  zipCode: list[index],
                  refreshListCallback: _refreshList,
                  isAreaSubtitleVisible: true,
                  trailing: list[index].fave == 1
                      ? Icon(
                          Platform.isAndroid
                              ? Icons.favorite
                              : CupertinoIcons.heart_solid,
                          color: Colors.redAccent,
                          size: 14.0,
                        )
                      : null,
                );
              },
            );
          }
        }
      },
    );
  }
}
