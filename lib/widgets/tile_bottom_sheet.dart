import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zipcodeph_flutter/constants.dart';
import 'package:zipcodeph_flutter/controllers/faves_controller.dart';
import 'package:zipcodeph_flutter/controllers/zips_controller.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/services/url_launcher.dart';
import 'package:zipcodeph_flutter/widgets/bottom_sheet_action_button.dart';

class ItemBottomSheet extends StatelessWidget {
  ItemBottomSheet({
    Key? key,
    required this.zipCode,
    required this.refreshListCallback,
  }) : super(key: key);

  final ZipCode zipCode;
  final VoidCallback refreshListCallback;
  final ZipsController _zipsController = ZipsController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "${zipCode.code} ${zipCode.town}, ${zipCode.area}",
              style: kTileLeadingTextStyle,
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
                content: Text("Copied $data"),
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
                content: Text(
                  zipCode.fave == 0
                      ? "Removed $data from favorites"
                      : "Added $data to favroties",
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
                  "https://google.com/maps/search/${zipCode.town}," +
                      zipCode.area);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          BottomSheetActionTile(
            icon: const Icon(Icons.close),
            label: "Cancel",
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
