import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zipcodeph_flutter/constants.dart';

import '../models/zipcode.dart';

class ZipCodeCard extends StatelessWidget {
  const ZipCodeCard(
      {super.key,
      required this.zipCode,
      this.refreshListCallback,
      this.showSubtitle = false,
      this.showTrailing = false});

  final ZipCode zipCode;
  final VoidCallback? refreshListCallback;
  final bool? showSubtitle;
  final bool? showTrailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {},
      onTap: () {
        Clipboard.setData(ClipboardData(
            text: "${zipCode.code} ${zipCode.town}, ${zipCode.area}"));
        var snackBar = SnackBar(
          content:
              Text("Copied ${zipCode.code} ${zipCode.town}, ${zipCode.area}"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${zipCode.code}',
                style: kTileLargerLeadingTextStyle,
              ),
              Text(zipCode.town),
              Text(zipCode.area)
            ],
          ),
        ),
      ),
    );
  }
}
