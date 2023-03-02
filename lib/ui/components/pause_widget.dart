import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import '../../main.dart';
import '../../scenes/main_game_scene.dart';
import '../../state/main_game_state.dart';
import '../../utils/nav_helper.dart';
import 'pop_button.dart';

class PauseWidget extends StatelessWidget with GetItMixin {
  final mainGameState = getIt<MainGameState>();
  final MainGameScene game;
  PauseWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final isPause = watchOnly((MainGameState state) => state.isPause);

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          AnimatedContainer(
            color: Colors.black.withOpacity(isPause ? 0.5 : 0),
            duration: const Duration(milliseconds: 100),
          ),
          PauseDialog(game: game)
              .animate(target: isPause ? 1 : 0)
              .scaleXY(
                duration: const Duration(milliseconds: 500),
                curve: isPause ? Curves.elasticOut : Curves.elasticIn,
              )
              .fadeIn(duration: const Duration(milliseconds: 500)),
          Positioned(
            top: 24,
            right: 24,
            child: PopButton(
              onTap: () => togglePause(isPause),
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
      ),
    );
  }

  void togglePause(bool isPause) {
    mainGameState.setPause(!isPause);
    if (!isPause) {
      FlameAudio.bgm.pause();
      game.pauseEngine();
    } else {
      FlameAudio.bgm.resume();
      game.resumeEngine();
    }
  }
}

class PauseDialog extends StatelessWidget with GetItMixin {
  final mainGameState = getIt<MainGameState>();
  final MainGameScene game;
  PauseDialog({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final isPause = watchOnly((MainGameState state) => state.isPause);

    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 400,
            padding: const EdgeInsets.all(42),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text(
                  'Game is paused',
                  style: TextStyle(
                    fontFamily: 'monogram',
                    fontSize: 32,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 24,
                    bottom: 12,
                  ),
                  child: PopButton(
                    text: 'Resume',
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    onTap: () => togglePause(isPause),
                  ),
                ),
                PopButton(
                  text: 'Exit',
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  onTap: () {
                    mainGameState.setPause(false);
                    NavHelper.pop();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void togglePause(bool isPause) {
    mainGameState.setPause(!isPause);
    if (!isPause) {
      FlameAudio.bgm.pause();
      game.pauseEngine();
    } else {
      FlameAudio.bgm.resume();
      game.resumeEngine();
    }
  }
}
