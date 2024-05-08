import 'package:flutter/material.dart';
import '/widgets/zipcode_tile.dart';

import '../models/zipcode.dart';
import 'not_found.dart';

class ZipCodesList extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ZipCodesList({
    super.key,
    this.city,
    required this.future,
    required this.errorText,
    this.showSubtitle = false,
    this.emptyGraphics,
    this.showTrailing = false,
    this.refreshCallback,
  });

  final String? city;
  final Future<List<ZipCode>?> future;
  final String errorText;
  final bool? showSubtitle;

  final EmptyGraphics? emptyGraphics;
  final bool? showTrailing;
  final VoidCallback? refreshCallback;

  @override
  State<ZipCodesList> createState() => _ZipCodesListState();
}

class _ZipCodesListState extends State<ZipCodesList> {
  void _refreshList() {
    widget.refreshCallback?.call();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ZipCode>?>(
      future: widget.future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Center(
              child: Text("Error loading ZIP codes."),
            );
          } else {
            return const Center(
              child: Text("Loading ZIP codes."),
            );
          }
        } else {
          final List<ZipCode> list = snapshot.data!;
          list.sort((a,b) => a.town.compareTo(b.town));
          debugPrint(list.length.toString());
          if (list.isEmpty && widget.emptyGraphics != null) {
            return widget.emptyGraphics!;
          } else {
            return ListView.separated(
              padding: const EdgeInsets.only(bottom: 80.0),
              shrinkWrap: true,
              separatorBuilder: (_, index) => const Divider(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ZipCodeTile(
                  zipCode: list[index],
                  refreshListCallback: _refreshList,
                  showTrailing: widget.showTrailing,
                  showSubtitle: widget.showSubtitle,
                );
              },
            );
          }
        }
      },
    );
  }
}
