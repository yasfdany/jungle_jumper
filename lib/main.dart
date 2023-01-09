import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jungle_jumper/scenes/main_game_scene.dart';
import 'package:jungle_jumper/state/main_game_state.dart';
import 'package:jungle_jumper/ui/pause_widget.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<MainGameState>(MainGameState());
  runApp(GameWidget(
    game: MainGameScene(),
    initialActiveOverlays: const ["pause"],
    overlayBuilderMap: {
      "pause": (contex, game) {
        return PauseWidget(game: game as MainGameScene);
      }
    },
  ));
}
