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

  _onDragEnd({
    required bool horizontal,
    required final DragStartDetails start,
    required final DragUpdateDetails last,
    required final DragEndDetails end,
    final VoidCallback? onBegin,
    final VoidCallback? onEnd,
  }) {
    Offset offset = last.globalPosition - start.globalPosition;
    double primaryOffset = horizontal ? offset.dx : offset.dy;
    if (primaryOffset != 0.0) {
      primaryOffset < 0.0 ? onBegin?.call() : onEnd?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) => startH = details,
      onHorizontalDragUpdate: (details) => lastH = details,
      onHorizontalDragEnd: (details) => _onDragEnd(
        horizontal: true,
        start: startH,
        last: lastH,
        end: details,
        onBegin: widget.onSwipeLeft,
        onEnd: widget.onSwipeRight,
      ),
      onVerticalDragStart: (details) => startV = details,
      onVerticalDragUpdate: (details) => lastV = details,
      onVerticalDragEnd: (details) => _onDragEnd(
        horizontal: false,
        start: startV,
        last: lastV,
        end: details,
        onBegin: widget.onSwipeUp,
        onEnd: widget.onSwipeDown,
      ),
      child: widget.child,
    );
  }
}
