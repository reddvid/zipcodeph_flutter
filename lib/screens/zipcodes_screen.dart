import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zipcodeph_flutter/controllers/zips_controller.dart';
import 'package:zipcodeph_flutter/main.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';

class ZipsPage extends StatefulWidget {
  const ZipsPage({
    Key? key,
    required this.area,
  }) : super(key: key);

  final List<String> area;

  @override
  State<ZipsPage> createState() => _ZipsPageState();
}

class _ZipsPageState extends State<ZipsPage> {
  void _refreshList() {
    setState(() {});
  }

  @override
  final ZipsController _zipsController = ZipsController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.area[0],
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        Text(widget.area[1],
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ])),
      body: _List(_zipsController, widget.area[1], _refreshList),
    );
  }
}

class _List extends StatelessWidget {
  final ZipsController _zipsController;
  final VoidCallback _refreshList;
  final String _area;
  const _List(this._zipsController, this._area, this._refreshList);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ZipCode>?>(
        future: _zipsController.getAreaCodes(_area),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: Text("Can't load ZIP codes. Send Feedback"));
          } else {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ZipCode zipCode = snapshot.data![index];
                return ListTile(
                    onLongPress: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return bottomSheet(
                                context, snapshot.data![index], _refreshList);
                          });
                    },
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return bottomSheet(
                                context, snapshot.data![index], _refreshList);
                          });
                    },
                    visualDensity:
                        const VisualDensity(vertical: -4), // to compact
                    leading: Container(
                        width: 48,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          zipCode.code.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                    subtitle: Text(zipCode.area),
                    title: Text(zipCode.town));
              },
            );
          }
        });
  }

  bottomSheet(
      BuildContext context, ZipCode zipCode, VoidCallback _refreshList) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "${zipCode.code} ${zipCode.town}, ${zipCode.area}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text("Copy"),
            onTap: () {
              Clipboard.setData(ClipboardData(
                  text: "${zipCode.code} ${zipCode.town}, ${zipCode.area}"));
              Navigator.pop(context);
              var snackBar = SnackBar(
                content: Text(
                    "Copied ${zipCode.code} ${zipCode.town}, ${zipCode.area}"),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          zipCode.fave == 1
              ? ListTile(
                  leading: const Icon(Icons.heart_broken_outlined),
                  title: const Text("Remove from favorites"),
                  onTap: () {
                    zipCode.fave = 0;
                    _zipsController.updateItem(zipCode);
                    _refreshList();
                    Navigator.pop(context);
                    var snackBar = SnackBar(
                      content: Text(
                          "Removed ${zipCode.code} ${zipCode.town}, ${zipCode.area} from favorites"),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          zipCode.fave = 1;
                          _zipsController.updateItem(zipCode);
                          _refreshList();
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                )
              : ListTile(
                  leading: const Icon(Icons.favorite_border),
                  title: const Text("Add to favorites"),
                  onTap: () {
                    zipCode.fave = 1;
                    _zipsController.updateItem(zipCode);
                    _refreshList();
                    Navigator.pop(context);
                    var snackBar = SnackBar(
                      content: Text(
                          "Added ${zipCode.code} ${zipCode.town}, ${zipCode.area} to favorites"),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          zipCode.fave = 0;
                          _zipsController.updateItem(zipCode);
                          _refreshList();
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
          ListTile(
            leading: const Icon(Icons.map_outlined),
            title: const Text("Open in Maps"),
            onTap: () {
              _launchUrl(
                  "https://google.com/maps/search/${zipCode.town}, ${zipCode.area}");
              Navigator.pop(context);
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text("Cancel"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}
