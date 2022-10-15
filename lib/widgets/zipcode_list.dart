import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/controllers/zips_controller.dart';
import 'package:zipcodeph_flutter/widgets/zipcode_tile.dart';

import '../models/zipcode.dart';

class ZipCodesList extends StatefulWidget {
  const ZipCodesList({
    Key? key,
    required this.city,
    this.isVisible = false,
  }) : super(key: key);

  final String city;
  final bool? isVisible;

  @override
  State<ZipCodesList> createState() => _ZipCodesListState();
}

class _ZipCodesListState extends State<ZipCodesList> {
  void _refreshList() {
    setState(() {});
  }

  final ZipsController _zipsController = ZipsController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ZipCode>?>(
      future: _zipsController.getAreaCodes(widget.city),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text("Error loading ZIP codes."),
          );
        } else {
          final List<ZipCode> list = snapshot.data!;
          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, index) => const Divider(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ZipCodeTile(
                zipCode: list[index],
                refreshListCallback: _refreshList,
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
      },
    );
  }
}
