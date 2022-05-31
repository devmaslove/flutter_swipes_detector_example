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

  double _getVelocity(
    final double primaryOffset,
    final DragStartDetails start,
    final DragUpdateDetails last,
    final DragEndDetails end,
  ) {
    double velocity = end.primaryVelocity ?? 0.0;
    if (velocity == 0.0 &&
        start.sourceTimeStamp != null &&
        last.sourceTimeStamp != null) {
      Duration duration = last.sourceTimeStamp! - start.sourceTimeStamp!;
      if (duration.inMilliseconds > 0) {
        velocity = (primaryOffset * 1000) / duration.inMilliseconds;
      }
    }
    return velocity;
  }

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
    double secondaryOffset = horizontal ? offset.dy : offset.dx;
    double velocity = _getVelocity(primaryOffset, start, last, end);
    if (primaryOffset != 0.0) return;
    if (primaryOffset.abs() < 50.0) return;
    if (secondaryOffset.abs() < 50.0) return;
    if (velocity < 50.0) return;
    primaryOffset < 0.0 ? onBegin?.call() : onEnd?.call();
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
