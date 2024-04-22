import 'package:flutter/material.dart';

class TileIcon extends StatelessWidget {
  const TileIcon({
    super.key,
    required this.iconData,
    required this.label,
    required this.onTap,
  });

  final IconData iconData;
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      minLeadingWidth: 0,
      title: Text(label),
      onTap: () => onTap(),
    );
  }
}
