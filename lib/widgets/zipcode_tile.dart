import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/constants.dart';

import '../models/zipcode.dart';
import 'zipitem_bottom_sheet.dart';

class ZipCodeTile extends StatelessWidget {
  const ZipCodeTile({
    Key? key,
    required this.zipCode,
    required this.refreshListCallback,
    this.isAreaSubtitleVisible = false,
    this.trailing,
  }) : super(key: key);

  final ZipCode zipCode;
  final VoidCallback refreshListCallback;
  final bool? isAreaSubtitleVisible;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ItemBottomSheet(
              zipCode: zipCode,
              refreshListCallback: refreshListCallback,
            );
          },
        );
      },
      visualDensity: const VisualDensity(vertical: -4.0),
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
      trailing: trailing,
      title: Text(zipCode.town),
      subtitle: isAreaSubtitleVisible == true ? Text(zipCode.area) : null,
    );
  }
}
