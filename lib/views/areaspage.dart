import 'package:flutter/material.dart';
import '../main.dart';
import '../repositories/area.dart';
import '../views/zipspage.dart';

class AreasPage extends StatefulWidget {
  final String area;

  const AreasPage({Key? key, required this.area}) : super(key: key);

  @override
  State<AreasPage> createState() => _AreasPageState();
}

class _AreasPageState extends State<AreasPage> with RouteAware {
  final AreaRepository _areaRepository = AreaRepository();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
  }

  @override
  Widget build(BuildContext context) {
    var menu = _areaRepository.menu(widget.area);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.area,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 80),
            separatorBuilder: (context, index) => const Divider(),
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
            },
          ),
        ],
      ),
    );
  }
}
