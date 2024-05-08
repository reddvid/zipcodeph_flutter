import 'dart:ui';

import 'package:flutter/material.dart';
import '/widgets/menu/menu_button_text.dart';

class GroupMenuButton extends StatelessWidget {
  const GroupMenuButton({
    super.key,
    required this.title,
    required this.backgroundImagePath,
    required this.height,
  });

  final String title;
  final String backgroundImagePath;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            image: DecorationImage(
              image: AssetImage(backgroundImagePath),
              fit: BoxFit.fitWidth,
            ),
          ),
          width: double.infinity,
          height: height,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              alignment: Alignment.center,
              child: MenuInkwell(
                title: title,
                height: height,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
