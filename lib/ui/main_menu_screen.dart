import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:jungle_jumper/ui/pop_button.dart';
import 'package:jungle_jumper/utils/extensions.dart';
import 'package:jungle_jumper/utils/nav_helper.dart';

import '../r.dart';
import 'main_game_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

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
                      FlameAudio.play(AssetAudio.jump.fileName, volume: 0.5);
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
