import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zipcodeph_flutter/constants.dart';

import '../models/zipcode.dart';
import 'tile_bottom_sheet.dart';

class ZipCodeTile extends StatelessWidget {
  const ZipCodeTile({
    super.key,
    required this.zipCode,
    this.refreshListCallback,
    this.showSubtitle = false,
    this.showTrailing = false,
  });

  final ZipCode zipCode;
  final VoidCallback? refreshListCallback;
  final bool? showSubtitle;
  final bool? showTrailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Clipboard.setData(ClipboardData(
            text: "${zipCode.code} ${zipCode.town}, ${zipCode.area}"));
        var snackBar = SnackBar(
          content:
              Text("Copied ${zipCode.code} ${zipCode.town}, ${zipCode.area}"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onLongPress: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (context) {
            return ItemBottomSheet(
              zipCode: zipCode,
              refreshListCallback: refreshListCallback!,
            );
          },
        );
      },
      visualDensity: kTileVisualDensity,
      leading: Container(
        width: MediaQuery.of(context).size.width > 800 ? 64 : 48.0,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          "${zipCode.code}",
          textAlign: TextAlign.center,
          style: MediaQuery.of(context).size.width > 800
              ? kTileLargerLeadingTextStyle
              : kTileLeadingTextStyle,
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
