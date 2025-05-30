import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/ball.dart';
import '../models/game_state.dart';
import '../constants/game_constants.dart';

class GameLogic {
  final GameState gameState;
  final VoidCallback onGameOver;
  final VoidCallback onBallCaught;
  final VoidCallback onStateChanged;

  List<Ball> balls = [];
  Timer? gameTimer;
  Timer? ballSpawnTimer;
  final Random random = Random();
  double _screenWidth = 0;
  double _screenHeight = 0;

  GameLogic({
    required this.gameState,
    required this.onGameOver,
    required this.onBallCaught,
    required this.onStateChanged,
  });

  void updateScreenSize(double width, double height) {
    _screenWidth = width;
    _screenHeight = height;
  }

  void startGame() {
    gameState.start();
    balls.clear();
    _startGameLoop();
    onStateChanged();
  }

  void pauseGame() {
    gameState.pause();
    onStateChanged();
  }

  void resumeGame() {
    gameState.resume();
    onStateChanged();
  }

  void restartGame() {
    stopTimers();
    startGame();
  }

  void quitGame() {
    stopTimers();
    gameState.stop();
    balls.clear();
    onStateChanged();
  }

  void _startGameLoop() {
    gameTimer = Timer.periodic(
      const Duration(milliseconds: GameConstants.gameLoopInterval),
      (timer) {
        if (!gameState.isGameRunning || gameState.isGamePaused) return;
        updateGame();
      },
    );

    ballSpawnTimer = Timer.periodic(
      const Duration(milliseconds: GameConstants.ballSpawnInterval),
      (timer) {
        if (!gameState.isGameRunning || gameState.isGamePaused) return;
        spawnBall();
      },
    );
  }

  void spawnBall() {
    if (_screenWidth == 0) return;

    balls.add(Ball(
      x: random.nextDouble() * (_screenWidth - 30),
      y: -30,
      speed: GameConstants.ballMinSpeed +
          random.nextDouble() *
              (GameConstants.ballMaxSpeed - GameConstants.ballMinSpeed),
      color: GameConstants
          .ballColors[random.nextInt(GameConstants.ballColors.length)],
      size: GameConstants.ballMinSize +
          random.nextDouble() *
              (GameConstants.ballMaxSize - GameConstants.ballMinSize),
    ));
    onStateChanged();
  }

  void updateGame() {
    if (_screenHeight == 0) return;

    for (int i = balls.length - 1; i >= 0; i--) {
      balls[i].y += balls[i].speed;

      // Check collision with bucket
      if (_checkBucketCollision(balls[i])) {
        gameState.score += GameConstants.pointsPerBall;
        balls.removeAt(i);
        onBallCaught();
        continue;
      }

      // Remove balls that fell off screen
      if (balls[i].y > _screenHeight) {
        balls.removeAt(i);
        gameState.lives--;
        if (gameState.lives <= 0) {
          gameOver();
          return;
        }
      }
    }
    onStateChanged();
  }

  bool _checkBucketCollision(Ball ball) {
    return ball.y + ball.size >= gameState.bucketY &&
        ball.y <= gameState.bucketY + GameConstants.bucketHeight &&
        ball.x + ball.size >= gameState.bucketX &&
        ball.x <= gameState.bucketX + GameConstants.bucketWidth;
  }

  void gameOver() {
    stopTimers();
    gameState.stop();
    onGameOver();
  }

  void moveBucket(double deltaX) {
    if (!gameState.isGameRunning || gameState.isGamePaused || _screenWidth == 0)
      return;

    gameState.bucketX += deltaX;
    if (gameState.bucketX < 0) gameState.bucketX = 0;
    if (gameState.bucketX > _screenWidth - GameConstants.bucketWidth) {
      gameState.bucketX = _screenWidth - GameConstants.bucketWidth;
    }
    onStateChanged();
  }

  void stopTimers() {
    gameTimer?.cancel();
    ballSpawnTimer?.cancel();
  }

  void dispose() {
    stopTimers();
  }
}
