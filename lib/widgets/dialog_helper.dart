import 'package:flutter/material.dart';
import '../models/game_state.dart';

class DialogHelper {
  static void showGameOverDialog(
    BuildContext context,
    GameState gameState,
    VoidCallback onPlayAgain,
    VoidCallback onMainMenu,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.sports_basketball,
                  size: 50, color: Colors.orange),
              const SizedBox(height: 10),
              Text('Final Score: ${gameState.score}',
                  style: const TextStyle(fontSize: 20)),
              if (gameState.score == gameState.highScore &&
                  gameState.score > 0) ...[
                const SizedBox(height: 5),
                Text('🎉 New High Score! 🎉',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.amber[700],
                        fontWeight: FontWeight.bold)),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: onMainMenu,
              child: const Text('Main Menu'),
            ),
            TextButton(
              onPressed: onPlayAgain,
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  static void showPauseDialog(
    BuildContext context,
    VoidCallback onResume,
    VoidCallback onRestart,
    VoidCallback onQuit,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Paused'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.pause_circle, size: 50, color: Colors.blue),
              SizedBox(height: 10),
              Text('What would you like to do?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: onResume,
              child: const Text('Resume'),
            ),
            TextButton(
              onPressed: onRestart,
              child: const Text('Restart'),
            ),
            TextButton(
              onPressed: onQuit,
              child: const Text('Quit'),
            ),
          ],
        );
      },
    );
  }
}
