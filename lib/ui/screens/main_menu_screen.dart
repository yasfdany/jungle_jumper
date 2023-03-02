import 'package:flutter/material.dart';
import 'package:jungle_jumper/utils/nav_helper.dart';

import '../../main.dart';
import '../../state/main_game_state.dart';
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
          const ForestBackGround(),
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
        ],
      ),
    );
  }
}

class ForestBackGround extends StatelessWidget {
  const ForestBackGround({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < 5; i++)
          Image.asset(
            'assets/images/plx_${i + 1}.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
      ],
    );
  }
}
