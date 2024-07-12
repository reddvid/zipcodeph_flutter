import 'dart:ui';
import 'package:flutter/material.dart';
import '../views/cities_screen.dart';

class AreaMenuButton extends StatelessWidget {
  const AreaMenuButton({
    super.key,
    required this.bgImage,
    required this.label,
  });

  final AssetImage bgImage;
  final String label;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 6.5;
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
              image: DecorationImage(
                image: bgImage,
                fit: BoxFit.fitWidth,
              ),
            ),
            width: double.infinity,
            height: height,
            height: height,
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0.0,
                sigmaY: 0.0,
              ),
              child: Container(
                color: const Color(0x10888888),
                alignment: Alignment.center,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AreasPage(area: label),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: height,
                      height: height,
                      child: Center(
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
