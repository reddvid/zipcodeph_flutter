import 'package:flutter/material.dart';
import '/constants.dart';
import '/views/zipcodes_screen.dart';

import '../models/areas_data.dart';

class AreasPage extends StatefulWidget {
  const AreasPage({
    super.key,
    required this.area,
  });

  final String area;
  @override
  State<AreasPage> createState() => _AreasPageState();
}

class _AreasPageState extends State<AreasPage> {
  final AreaRepository _areaRepository = AreaRepository();

  @override
  Widget build(BuildContext context) {
    var menu = _areaRepository.menu(widget.area);
    menu.sort((a,b) => a.compareTo(b));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.area.toUpperCase(),
          style: kAppBarTitleStyle,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(bottom: 80.0),
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
        ),
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity: const VisualDensity(vertical: -4.0), // to compact
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              menu[index],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ZipsPage(
                    area: widget.area,
                    city: menu[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
