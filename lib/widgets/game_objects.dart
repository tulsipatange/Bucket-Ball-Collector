import 'package:flutter/material.dart';
import '../models/ball.dart';
import '../constants/game_constants.dart';

class GameObjects {
  static Widget buildBall(Ball ball) {
    return Positioned(
      left: ball.x,
      top: ball.y,
      child: Container(
        width: ball.size,
        height: ball.size,
        decoration: BoxDecoration(
          color: ball.color,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildBucket(double bucketX, double bucketY, Animation<double> bucketAnimation) {
    return Positioned(
      left: bucketX,
      top: bucketY,
      child: AnimatedBuilder(
        animation: bucketAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: bucketAnimation.value,
            child: Container(
              width: GameConstants.bucketWidth,
              height: GameConstants.bucketHeight,
              decoration: BoxDecoration(
                color: Colors.brown[600],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                border: Border.all(color: Colors.brown[800]!, width: 3),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}