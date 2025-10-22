import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/widgets/not_found.dart';
import 'package:zipcodeph_flutter/widgets/zipcode_tile.dart';

import '../models/zipcode.dart';

class ZipCodesList extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ZipCodesList({
    Key? key,
    this.city,
    required this.future,
    required this.errorText,
    this.showSubtitle = false,
    this.emptyGraphics,
    this.showTrailing = false,
    this.refreshCallback,
  }) : super(key: key);

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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(widget.errorText),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return widget.emptyGraphics ??
              const Center(child: Text("No data available"));
        } else {
          final List<ZipCode> list = snapshot.data!;
          debugPrint('ZIP codes loaded: ${list.length}');

          if (list.isEmpty && widget.emptyGraphics != null) {
            return widget.emptyGraphics!;
          } else {
            // Use ListView.builder with lazy loading for better memory management
            return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(), // Better for memory
              itemCount: list.length +
                  (list.length > 0
                      ? list.length - 1
                      : 0), // Account for separators
              itemBuilder: (context, index) {
                // Handle separators
                if (index.isOdd) {
                  return const Divider();
                }

                final itemIndex = index ~/ 2;
                if (itemIndex >= list.length) return const SizedBox.shrink();

                return ZipCodeTile(
                  zipCode: list[itemIndex],
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
