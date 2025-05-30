import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../services/game_logic.dart';
import '../widgets/game_ui.dart';
import '../widgets/game_objects.dart';
import '../widgets/dialog_helper.dart';
import '../constants/game_constants.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late GameState gameState;
  late GameLogic gameLogic;
  late AnimationController _bucketController;
  late Animation<double> _bucketAnimation;

  @override
  void initState() {
    super.initState();
    gameState = GameState();

    _bucketController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _bucketAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _bucketController, curve: Curves.elasticOut),
    );

    gameLogic = GameLogic(
      gameState: gameState,
      onGameOver: _onGameOver,
      onBallCaught: _onBallCaught,
      onStateChanged: _onStateChanged,
    );
  }

  void _onGameOver() {
    if (!mounted) return;
    DialogHelper.showGameOverDialog(
      context,
      gameState,
      () {
        Navigator.of(context).pop();
        gameLogic.startGame();
      },
      () => Navigator.of(context).pop(),
    );
  }

  void _onBallCaught() {
    _bucketController.forward().then((_) {
      if (mounted) {
        _bucketController.reverse();
      }
    });
  }

  void _onStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _showPauseMenu() {
    DialogHelper.showPauseDialog(
      context,
      () {
        Navigator.of(context).pop();
        gameLogic.resumeGame();
      },
      () {
        Navigator.of(context).pop();
        gameLogic.restartGame();
      },
      () {
        Navigator.of(context).pop();
        gameLogic.quitGame();
      },
    );
  }

  @override
  void dispose() {
    gameLogic.dispose();
    _bucketController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Update screen size in game logic
    gameLogic.updateScreenSize(screenWidth, screenHeight);
    gameState.bucketY = screenHeight - 150;

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text('Bucket Ball Collector'),
        backgroundColor: Colors.blue[600],
        elevation: 0,
        actions: [
          if (gameState.isGameRunning && !gameState.isGamePaused) ...[
            IconButton(
              onPressed: () {
                gameLogic.pauseGame();
                _showPauseMenu();
              },
              icon: const Icon(Icons.pause),
              tooltip: 'Pause Game',
            ),
          ],
        ],
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlue[100]!, Colors.lightBlue[50]!],
              ),
            ),
          ),

          // Game Area
          if (gameState.isGameRunning && !gameState.isGamePaused) ...[
            // Balls
            ...gameLogic.balls
                .map((ball) => GameObjects.buildBall(ball))
                .toList(),

            // Bucket
            GameObjects.buildBucket(
                gameState.bucketX, gameState.bucketY, _bucketAnimation),

            // Score and Lives Display
            GameUI.buildScoreDisplay(gameState),

            // Control Buttons
            GameUI.buildControlButtons(
              () => gameLogic.moveBucket(-GameConstants.bucketMoveDistance),
              () => gameLogic.moveBucket(GameConstants.bucketMoveDistance),
            ),
          ],

          // Paused Overlay
          if (gameState.isGameRunning && gameState.isGamePaused) ...[
            GameUI.buildPausedOverlay(),
          ],

          // Start/Main Menu Screen
          if (!gameState.isGameRunning) ...[
            GameUI.buildMainMenuScreen(
              gameState,
              () => gameLogic.startGame(),
              () => setState(() => gameState.resetHighScore()),
            ),
          ],
        ],
      ),
    );
  }
}
