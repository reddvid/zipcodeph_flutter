import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/zipcode.dart';

class ZipCodesList extends StatelessWidget {
  const ZipCodesList({Key? key}) : super(key: key);

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        // return bottomSheet(context, snapshot.data![index], _refreshList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ZipCode>>(
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
              return ListTile(
                onLongPress: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      // return bottomSheet(context, snapshot.data![index], _refreshList);
                    },
                  );
                },
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      // return bottomSheet(context, snapshot.data![index], _refreshList);
                    },
                  );
                },
                visualDensity: const VisualDensity(vertical: -4.0),
              );
            },
          );
        }
      },
    );
  }
}
