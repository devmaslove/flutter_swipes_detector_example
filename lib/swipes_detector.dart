import 'package:flutter/material.dart';

class SwipesDetector extends StatefulWidget {
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
  State<SwipesDetector> createState() => _SwipesDetectorState();
}

class _SwipesDetectorState extends State<SwipesDetector> {
  // Vertical drag details
  DragStartDetails startV = DragStartDetails();
  DragUpdateDetails lastV = DragUpdateDetails(
    globalPosition: const Offset(0, 0),
  );

  // Horizontal drag details
  DragStartDetails startH = DragStartDetails();
  DragUpdateDetails lastH = DragUpdateDetails(
    globalPosition: const Offset(0, 0),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) => startH = details,
      onHorizontalDragUpdate: (details) => lastH = details,
      onHorizontalDragEnd: (details) {
        Offset offset = lastH.globalPosition - startH.globalPosition;
        double primaryOffset = offset.dx;
        if (primaryOffset > 0.0) return widget.onSwipeRight();
        if (primaryOffset < 0.0) return widget.onSwipeLeft();
      },
      onVerticalDragStart: (details) => startV = details,
      onVerticalDragUpdate: (details) => lastV = details,
      onVerticalDragEnd: (details) {
        Offset offset = lastV.globalPosition - startV.globalPosition;
        double primaryOffset = offset.dy;
        if (primaryOffset > 0.0) return widget.onSwipeDown();
        if (primaryOffset < 0.0) return widget.onSwipeUp();
      },
      child: widget.child,
    );
  }
}
