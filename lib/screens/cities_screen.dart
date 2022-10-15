import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/main.dart';
import 'package:zipcodeph_flutter/models/areas_data.dart';
import 'package:zipcodeph_flutter/screens/zipcodes_screen.dart';

class AreasPage extends StatefulWidget {
  final String area;
  const AreasPage({Key? key, required this.area}) : super(key: key);

  @override
  State<AreasPage> createState() => _AreasPageState();
}

class _AreasPageState extends State<AreasPage> {
  final AreaRepository _areaRepository = AreaRepository();

  @override
  Widget build(BuildContext context) {
    var menu = _areaRepository.menu(widget.area);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.area,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                ),
            itemCount: menu.length,
            itemBuilder: (context, index) {
              return ListTile(
                visualDensity: const VisualDensity(vertical: -4), // to compact
                trailing: const Icon(Icons.chevron_right),
                title: Text(
                  menu[index],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ZipsPage(area: [widget.area, menu[index]])));
                },
              );
            }));
  }
}
