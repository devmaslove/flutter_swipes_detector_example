import 'package:flutter/material.dart';

class SwipesDetector extends StatelessWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeUp;
  final VoidCallback onSwipeDown;

  const SwipesDetector({
    Key? key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onSwipeUp,
    required this.onSwipeDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0.0) return onSwipeRight();
        if (details.primaryVelocity! < 0.0) return onSwipeLeft();
      },
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0.0) return onSwipeUp();
        if (details.primaryVelocity! < 0.0) return onSwipeDown();
      },
      child: child,
    );
  }
}
