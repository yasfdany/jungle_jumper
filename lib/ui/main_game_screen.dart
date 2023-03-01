import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../scenes/main_game_scene.dart';
import 'pause_widget.dart';

class MainGameScreen extends StatelessWidget {
  const MainGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MainGameScene(),
      initialActiveOverlays: const ["pause"],
      overlayBuilderMap: {
        "pause": (contex, game) {
          return PauseWidget(game: game as MainGameScene);
        }
      },
    );
  }
}
