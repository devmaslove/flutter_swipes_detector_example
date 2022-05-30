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
      child: child,
    );
  }
}
