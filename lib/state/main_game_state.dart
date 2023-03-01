import 'package:flutter/foundation.dart';

class MainGameState extends ChangeNotifier {
  bool isPause = false;
  bool isGameStart = false;
  bool isGameOver = false;

  void setPause(bool pause) {
    isPause = pause;
    notifyListeners();
  }

  void setGameState(bool gameStart) {
    isGameStart = gameStart;
    notifyListeners();
  }

  void setGameOver(bool gameOver) {
    isGameOver = gameOver;
    notifyListeners();
  }
}
