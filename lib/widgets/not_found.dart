import 'package:flutter/material.dart';

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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: image,
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  promptText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 10.0),
                // ElevatedButton(
                //   onPressed: () => onPressed(),
                //   child: Text(buttonLabel),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
