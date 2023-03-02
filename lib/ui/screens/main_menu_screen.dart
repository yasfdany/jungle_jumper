import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jungle_jumper/utils/nav_helper.dart';

import '../../main.dart';
import '../../state/main_game_state.dart';
import '../components/forest_background.dart';
import '../components/pop_button.dart';
import 'main_game_screen.dart';

class MainMenuScreen extends StatelessWidget {
  final mainGameState = getIt<MainGameState>();
  MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NavHelper.initNavHelper(context);

    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: ForestBackground()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PopButton(
                    text: 'Start Game',
                    textSize: 32,
                    onTap: () {
                      mainGameState.loadHighScore();
                      NavHelper.navigatePush(const MainGameScreen());
                    },
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 32,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Created by StudioCloud',
                    style: TextStyle(
                      fontFamily: 'monogram',
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
