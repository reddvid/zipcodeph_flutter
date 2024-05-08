import 'package:flutter/material.dart';
import '../constants.dart';
import '../controllers/zips_controller.dart';
import '../widgets/zipcode_list.dart';

class ZipsPage extends StatefulWidget {
  const ZipsPage({
    super.key,
    required this.area,
    required this.city,
  });

  final String area;
  final String city;

  @override
  State<ZipsPage> createState() => _ZipsPageState();
}

class _ZipsPageState extends State<ZipsPage> {
  final ZipsController _zipsController = ZipsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.area.toUpperCase(),
              style: const TextStyle(
                fontSize: 10.0,
              ),
            ),
            Text(
              widget.city.toUpperCase(),
              style: kAppBarTitleStyle,
            ),
          ],
        ),
      ),
      body: ZipCodesList(
        city: widget.city,
        showTrailing: true,
        future: _zipsController.getAreaCodes(widget.city),
        errorText: "Error loading ZIP codes.",
      ),
    );
  }
}
