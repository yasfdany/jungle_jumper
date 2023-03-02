import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:jungle_jumper/scenes/main_game_scene.dart';
import 'package:jungle_jumper/utils/nav_helper.dart';

import '../../main.dart';
import '../../state/main_game_state.dart';
import '../screens/main_game_screen.dart';
import 'pop_button.dart';

class GameOverWidget extends StatelessWidget with GetItMixin {
  final mainGameState = getIt<MainGameState>();
  final MainGameScene game;

  GameOverWidget({super.key, required this.game}) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      _leftConfetty.play();
      _rightConfetty.play();
    });
  }

  final _leftConfetty =
      ConfettiController(duration: const Duration(seconds: 2));
  final _rightConfetty =
      ConfettiController(duration: const Duration(seconds: 2));

  @override
  Widget build(BuildContext context) {
    final isGameOver = watchOnly((MainGameState state) => state.isGameOver);
    final isShowConfetti =
        watchOnly((MainGameState state) => state.isShowConfetti);

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          AnimatedContainer(
            color: Colors.black.withOpacity(isGameOver ? 0.5 : 0),
            duration: const Duration(milliseconds: 100),
          ),
          GameOverDialog(game: game)
              .animate(target: isGameOver ? 1 : 0)
              .scaleXY(
                duration: const Duration(milliseconds: 500),
                curve: isGameOver ? Curves.elasticOut : Curves.elasticIn,
              )
              .fadeIn(duration: const Duration(milliseconds: 500)),
          if (isShowConfetti)
            Positioned(
              bottom: 0,
              left: 0,
              child: ConfettiWidget(
                confettiController: _leftConfetty,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.5,
                maxBlastForce: 150,
                shouldLoop: false,
                blastDirection: -pi / 2,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
              ),
            ),
          if (isShowConfetti)
            Positioned(
              bottom: 0,
              right: 0,
              child: ConfettiWidget(
                confettiController: _rightConfetty,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 150,
                emissionFrequency: 0.5,
                shouldLoop: false,
                blastDirection: -pi / 2,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
              ),
            ),
        ],
      ),
    );
  }
}

class GameOverDialog extends StatelessWidget with GetItMixin {
  final mainGameState = getIt<MainGameState>();
  final MainGameScene game;
  GameOverDialog({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final score = watchOnly((MainGameState state) => state.score);
    final highScore = watchOnly((MainGameState state) => state.highScore);

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
                Text(
                  score > highScore ? 'New High Score' : 'High Score',
                  style: const TextStyle(
                    fontFamily: 'monogram',
                    fontSize: 32,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    score > highScore ? '$score' : '$highScore',
                    style: const TextStyle(
                      fontFamily: 'monogram',
                      fontSize: 72,
                    ),
                  ),
                ),
                if (score <= highScore)
                  const Text(
                    'Your Score',
                    style: TextStyle(
                      fontFamily: 'monogram',
                      fontSize: 32,
                    ),
                  ),
                if (score <= highScore)
                  Text(
                    '$score',
                    style: const TextStyle(
                      fontFamily: 'monogram',
                      fontSize: 72,
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 24,
                    bottom: 12,
                  ),
                  child: PopButton(
                    text: 'Replay',
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    onTap: () {
                      mainGameState.loadHighScore();
                      NavHelper.navigateReplace(const MainGameScreen());
                    },
                  ),
                ),
                PopButton(
                  text: 'Exit',
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  onTap: () {
                    NavHelper.pop();
                    mainGameState.setPause(false);
                    mainGameState.setGameOver(false);
                    game.overlays.remove('game_over');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
