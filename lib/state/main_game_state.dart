import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:jungle_jumper/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../r.dart';

class MainGameState extends ChangeNotifier {
  late SharedPreferences _prefs;
  bool isShowConfetti = false;
  bool isPause = false;
  bool isGameOver = false;
  int score = 0;
  int highScore = 0;

  MainGameState() {
    loadHighScore();
  }

  Future loadHighScore() async {
    _prefs = await SharedPreferences.getInstance();
    // await _prefs.clear();
    isShowConfetti = false;
    highScore = _prefs.getInt('high_score') ?? 0;
  }

  void checkHighScore() async {
    await loadHighScore();
    if (score > highScore) {
      Future.delayed(const Duration(milliseconds: 500), () async {
        await FlameAudio.play(AssetAudio.win.fileName, volume: 0.5);
        Future.delayed(const Duration(seconds: 1), () {
          FlameAudio.play(AssetAudio.confetti.fileName, volume: 0.5);
          isShowConfetti = true;
          notifyListeners();
        });
      });
      _prefs.setInt('high_score', score);
      notifyListeners();
    }
  }

  void setPause(bool pause) {
    isPause = pause;
    notifyListeners();
  }

  void setGameOver(bool gameOver) {
    isGameOver = gameOver;
    notifyListeners();
  }
}
