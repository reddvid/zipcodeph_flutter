import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/widgets/zipcode_list.dart';

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
