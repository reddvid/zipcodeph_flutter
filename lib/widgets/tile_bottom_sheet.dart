import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../controllers/zips_controller.dart';
import '../models/zipcode.dart';
import '../services/url_launcher.dart';
import 'bottom_sheet_action_button.dart';

class ItemBottomSheet extends StatelessWidget {
  ItemBottomSheet({
    super.key,
    required this.zipCode,
    required this.refreshListCallback,
  });

  final ZipCode zipCode;
  final VoidCallback refreshListCallback;
  final ZipsController _zipsController = ZipsController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 24.0,
                  left: 24.0,
                  right: 24.0,
                ),
                child: Text(
                  "${zipCode.code} ${zipCode.town}, ${zipCode.area}",
                  style: kTileLeadingTextStyle,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          BottomSheetActionTile(
            icon: const Icon(Icons.copy),
            label: "Copy",
            onTap: () {
              final String data =
                  "${zipCode.code} ${zipCode.town}, ${zipCode.area}";
              Clipboard.setData(
                ClipboardData(text: data),
              );
              Navigator.of(context).pop();
              final SnackBar snackBar = SnackBar(
                margin: kSnackBarMargin,
                content: Text("Copied $data"),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          BottomSheetActionTile(
            icon: Icon(
              zipCode.fave == 1
                  ? Icons.heart_broken_outlined
                  : Icons.favorite_outline,
            ),
            label: zipCode.fave == 1
                ? "Remove from favorites"
                : "Add to favorites",
            onTap: () {
              final String data =
                  "${zipCode.code} ${zipCode.town}, ${zipCode.area}";

              if (zipCode.fave != 1) {
                _zipsController.faveItem(zipCode);
              } else {
                _zipsController.unFaveItem(zipCode);
              }

              refreshListCallback();

              Navigator.pop(context);

              final SnackBar snackBar = SnackBar(
                margin: kSnackBarMargin,
                content: Text(
                  zipCode.fave == 0
                      ? "Removed $data from favorites"
                      : "Added $data to favorites",
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          BottomSheetActionTile(
            icon: const Icon(Icons.map_outlined),
            label: "Open in Maps",
            onTap: () {
              UrlLauncher.openUrl(
                  "https://google.com/maps/search/${zipCode.town}, ${zipCode.area}");
              Navigator.pop(context);
            },
          ),
          // const Divider(),
          // BottomSheetActionTile(
          //   icon: const Icon(Icons.close),
          //   label: "Close",
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // )
        ],
      ),
    );
  }
}
