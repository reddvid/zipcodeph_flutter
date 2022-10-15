import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zipcodeph_flutter/constants.dart';
import 'package:zipcodeph_flutter/controllers/zips_controller.dart';
import 'package:zipcodeph_flutter/main.dart';
import 'package:zipcodeph_flutter/models/zipcode.dart';
import 'package:zipcodeph_flutter/widgets/zipcode_list.dart';
import 'package:zipcodeph_flutter/widgets/zipitem_bottom_sheet.dart';

class ZipsPage extends StatefulWidget {
  const ZipsPage({
    Key? key,
    required this.area,
    required this.city,
  }) : super(key: key);

  final String area;
  final String city;

  @override
  State<ZipsPage> createState() => _ZipsPageState();
}

class _ZipsPageState extends State<ZipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.area,
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
            Text(
              widget.city,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: ZipCodesList(city: widget.city),
    );
  }
}
