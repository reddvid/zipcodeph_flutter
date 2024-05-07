import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/zipcode.dart';
import 'tile_bottom_sheet.dart';

class ZipCodeTile extends StatelessWidget {
  const ZipCodeTile({
    Key? key,
    required this.zipCode,
    required this.refreshListCallback,
    this.showSubtitle = false,
    this.showTrailing = false,
  }) : super(key: key);

  final ZipCode zipCode;
  final VoidCallback refreshListCallback;
  final bool? showSubtitle;
  final bool? showTrailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModalBottomSheet<void>(
          showDragHandle: true,
          context: context,
          builder: (context) {
            return ItemBottomSheet(
              zipCode: zipCode,
              refreshListCallback: refreshListCallback,
            );
          },
        );
      },
      visualDensity: kTileVisualDensity,
      leading: Container(
        width: 48.0,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          "${zipCode.code}",
          textAlign: TextAlign.center,
          style: kTileLeadingTextStyle,
        ),
      ),
      trailing: (showTrailing == true)
          ? zipCode.fave == 1
              ? Icon(
                  Platform.isAndroid
                      ? Icons.favorite
                      : CupertinoIcons.heart_solid,
                  color: Colors.redAccent,
                  size: 14.0,
                )
              : null
          : null,
      title: Text(zipCode.town),
      subtitle: showSubtitle == true ? Text(zipCode.area) : null,
    );
  }
}
