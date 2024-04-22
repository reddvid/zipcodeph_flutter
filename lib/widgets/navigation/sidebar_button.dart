import 'package:flutter/material.dart';

class SidebarButton extends StatelessWidget {
  const SidebarButton({
    super.key,
    required this.label,
    this.icon,
  });

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          if (icon != null) Icon(icon) else const SizedBox(),
          Text(label),
        ],
      ),
    );
  }
}
