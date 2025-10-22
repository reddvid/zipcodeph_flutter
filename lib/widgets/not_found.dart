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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: image,
            width: MediaQuery.of(context).size.width * 0.6,
            filterQuality:
                FilterQuality.low, // Reduce memory for non-critical images
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              // Optimize loading behavior
              if (wasSynchronouslyLoaded) return child;
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
                child: child,
              );
            },
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
