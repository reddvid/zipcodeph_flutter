import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zipcodeph_flutter/constants.dart';

import '../models/zipcode.dart';
import 'zipitem_bottom_sheet.dart';

class ZipCodeTile extends StatelessWidget {
  const ZipCodeTile({
    Key? key,
    required this.zipCode,
    required this.refreshListCallback,
    this.isVisible = false,
  }) : super(key: key);

  final ZipCode zipCode;
  final VoidCallback refreshListCallback;
  final bool? isVisible;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
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
      title: Text(zipCode.town),
      subtitle: isVisible == true ? Text(zipCode.area) : null,
    );
  }
}
