import 'package:flutter/material.dart';
import 'package:swipes_detector/swipes_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipes Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Swipes Detector'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = 'Swipe me!';

  void _setText(String text) {
    setState(() {
      _text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SwipesDetector(
          onSwipeUp: () => _setText('Swipe Up'),
          onSwipeDown: () => _setText('Swipe Down'),
          onSwipeLeft: () => _setText('Swipe Left'),
          onSwipeRight: () => _setText('Swipe Right'),
          child: Container(
            color: Colors.blue,
            alignment: Alignment.center,
            width: 256,
            height: 164,
            child: Text(
              _text,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
