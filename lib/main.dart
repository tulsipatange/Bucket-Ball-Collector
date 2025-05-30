import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const BucketBallGame());
}

class BucketBallGame extends StatelessWidget {
  const BucketBallGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bucket Ball Collector',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Arial',
      ),
      home: const GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}