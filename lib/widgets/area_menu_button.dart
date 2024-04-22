import 'dart:ui';
import 'package:flutter/material.dart';

import '../views/areaspage.dart';

class AreaMenuButton extends StatelessWidget {
  const AreaMenuButton({
    Key? key,
    required this.bgImage,
    required this.label,
  }) : super(key: key);

  final AssetImage bgImage;
  final String label;

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height / 7.0;
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              image: DecorationImage(
                image: bgImage,
                fit: BoxFit.fitWidth,
              ),
            ),
            width: double.infinity,
            height: _height,
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
                      borderRadius: BorderRadius.circular(10.0),
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
                      height: _height,
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
