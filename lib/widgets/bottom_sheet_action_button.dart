import 'package:flutter/material.dart';

class BottomSheetActionTile extends StatelessWidget {
  const BottomSheetActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Icon icon;
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      minLeadingWidth: 0,
      title: Text(label),
      onTap: () => onTap(),
    );
  }
}
