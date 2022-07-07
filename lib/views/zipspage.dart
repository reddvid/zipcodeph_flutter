import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zipcodeph_flutter/main.dart';

class ZipsPage extends StatefulWidget {
  final List<String> area;
  const ZipsPage({Key? key, required this.area}) : super(key: key);

  @override
  State<ZipsPage> createState() => _ZipsPageState();
}

class _ZipsPageState extends State<ZipsPage> with RouteAware {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }

  @override
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
      Text(widget.area[1], style: const TextStyle(fontWeight: FontWeight.bold)),
    ])));
  }
}
