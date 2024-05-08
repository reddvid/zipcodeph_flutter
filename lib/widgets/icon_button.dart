import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  const ActionIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final Icon icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextButton.icon(
        icon: icon,
        label: Text(label),
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor:
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
        ),
      ),
    );
  }
}
