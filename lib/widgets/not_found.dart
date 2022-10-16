import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';

class EmptyGraphics extends StatelessWidget {
  const EmptyGraphics({
    Key? key,
    required this.image,
    required this.promptText,
    required this.onPressed,
    required this.buttonLabel,
  }) : super(key: key);

  final AssetImage image;
  final String promptText;
  final Function onPressed;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: image,
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          Text(
            promptText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () => onPressed(),
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}
