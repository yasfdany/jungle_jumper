import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:jungle_jumper/scenes/main_game_scene.dart';

class Score extends TextComponent with HasGameRef<MainGameScene> {
  final regular = TextPaint(
    style: const TextStyle(
      fontSize: 86,
      fontFamily: "monogram",
      color: Colors.white,
    ),
  );
  double score = 0;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    textRenderer = regular;
    anchor = Anchor.center;
    y = 76;
    text = "0";
  }

  @override
  void update(double dt) {
    super.update(dt);
    score += 1 * dt;
    text = score.toInt().toString();

    x = gameRef.size.x / 2;
  }

  void reset() {
    score = 0;
    text = "0";
  }
}
