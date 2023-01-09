import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:jungle_jumper/scenes/main_game_scene.dart';

import '../main.dart';
import '../state/main_game_state.dart';

class PauseWidget extends StatelessWidget with GetItMixin {
  final MainGameScene game;

  PauseWidget({super.key, required this.game});

  final mainGameState = getIt<MainGameState>();

  @override
  Widget build(BuildContext context) {
    final isPause = watchOnly((MainGameState state) => state.isPause);

    return Stack(
      children: [
        Positioned(
          top: 24,
          right: 24,
          child: GestureDetector(
            onTap: () {
              mainGameState.setPause(!isPause);
              if (!isPause) {
                FlameAudio.bgm.pause();
                game.pauseEngine();
              } else {
                FlameAudio.bgm.resume();
                game.resumeEngine();
              }
            },
            child: Icon(
              !isPause
                  ? Icons.pause_circle_filled_rounded
                  : Icons.play_circle_fill_rounded,
              size: 68,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
