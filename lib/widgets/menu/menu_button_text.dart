import 'package:flutter/material.dart';
import 'package:zipcodeph_flutter/views/areaspage.dart';

class MenuInkwell extends StatelessWidget {
  const MenuInkwell({super.key, required this.title, required this.height});

  final String title;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AreasPage(area: title)),
          );
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
