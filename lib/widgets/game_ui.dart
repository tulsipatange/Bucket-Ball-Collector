import 'package:flutter/material.dart';
import '../models/game_state.dart';

class GameUI {
  static Widget buildScoreDisplay(GameState gameState) {
    return Positioned(
      top: 20,
      left: 20,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Score: ${gameState.score}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text('Lives: ', style: TextStyle(fontSize: 16)),
                ...List.generate(
                    gameState.lives,
                    (index) => const Icon(Icons.favorite, color: Colors.red, size: 20)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildControlButtons(VoidCallback onMoveLeft, VoidCallback onMoveRight) {
    return Positioned(
      bottom: 50,
      left: 20,
      child: Row(
        children: [
          ElevatedButton(
            onPressed: onMoveLeft,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
            ),
            child: const Icon(Icons.arrow_left, size: 30),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: onMoveRight,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
            ),
            child: const Icon(Icons.arrow_right, size: 30),
          ),
        ],
      ),
    );
  }

  static Widget buildPausedOverlay() {
    return Container(
      color: Colors.black54,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pause_circle_filled, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'PAUSED',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Tap the pause button to continue',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildMainMenuScreen(
    GameState gameState, 
    VoidCallback onStart, 
    VoidCallback onResetHighScore
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.games, size: 100, color: Colors.blue[600]),
          const SizedBox(height: 20),
          Text(
            'Bucket Ball Collector',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Catch the falling balls with your bucket!',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          if (gameState.highScore > 0) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.amber[300]!, width: 2),
              ),
              child: Column(
                children: [
                  Icon(Icons.star, color: Colors.amber[700], size: 30),
                  const SizedBox(height: 5),
                  Text(
                    'High Score: ${gameState.highScore}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 40),
          Column(
            children: [
              ElevatedButton(
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 5,
                  minimumSize: const Size(200, 50),
                ),
                child: const Text(
                  'START GAME',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              if (gameState.highScore > 0) ...[
                ElevatedButton(
                  onPressed: onResetHighScore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Text(
                    'RESET HIGH SCORE',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}