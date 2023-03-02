import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jungle_jumper/ui/components/game_over_widget.dart';

import '../../scenes/main_game_scene.dart';
import '../components/pause_widget.dart';

class MainGameScreen extends StatelessWidget {
  const MainGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(
          game: MainGameScene(),
          initialActiveOverlays: const ["pause"],
          overlayBuilderMap: {
            "pause": (contex, game) {
              return PauseWidget(game: game as MainGameScene);
            },
            "game_over": (contex, game) {
              return GameOverWidget(game: game as MainGameScene);
            }
          },
        ),
      ],
    );
  }
}
