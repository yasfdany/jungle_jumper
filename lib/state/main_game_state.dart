import 'package:flutter/foundation.dart';

class MainGameState extends ChangeNotifier {
  bool isPause = false;

  void setPause(bool pause) {
    isPause = pause;
    notifyListeners();
  }
}
