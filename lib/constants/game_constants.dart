import 'package:flutter/material.dart';

class GameConstants {
  static const double bucketWidth = 80;
  static const double bucketHeight = 40;
  static const int ballSpawnInterval = 1200; // milliseconds
  static const int gameLoopInterval = 16; // milliseconds
  static const int pointsPerBall = 10;
  static const double ballMinSize = 20;
  static const double ballMaxSize = 35;
  static const double ballMinSpeed = 2;
  static const double ballMaxSpeed = 5;
  static const double bucketMoveDistance = 30;

  static const List<Color> ballColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ];
}
