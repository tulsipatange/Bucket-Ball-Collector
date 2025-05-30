class GameState {
  int score;
  int highScore;
  int lives;
  bool isGameRunning;
  bool isGamePaused;
  double bucketX;
  double bucketY;

  GameState({
    this.score = 0,
    this.highScore = 0,
    this.lives = 3,
    this.isGameRunning = false,
    this.isGamePaused = false,
    this.bucketX = 150,
    this.bucketY = 500,
  });

  void reset() {
    score = 0;
    lives = 3;
    isGameRunning = false;
    isGamePaused = false;
    bucketX = 150;
  }

  void pause() {
    isGamePaused = true;
  }

  void resume() {
    isGamePaused = false;
  }

  void start() {
    isGameRunning = true;
    isGamePaused = false;
    score = 0;
    lives = 3;
    bucketX = 150;
  }

  void stop() {
    isGameRunning = false;
    isGamePaused = false;
    if (score > highScore) {
      highScore = score;
    }
  }

  void resetHighScore() {
    highScore = 0;
  }
}