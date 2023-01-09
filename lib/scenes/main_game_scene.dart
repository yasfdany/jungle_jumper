import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jungle_jumper/components/land.dart';
import 'package:jungle_jumper/components/man.dart';
import 'package:jungle_jumper/components/mushroom.dart';
import 'package:jungle_jumper/components/parallax_background.dart';
import 'package:jungle_jumper/components/score.dart';
import 'package:jungle_jumper/r.dart';
import 'package:jungle_jumper/utils/extensions.dart';

class MainGameScene extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  final man = Man();

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSpace && isKeyDown) {
      man.jump();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Future<void>? onLoad() async {
    FlameAudio.bgm.play(AssetAudio.jungleBgm.fileName, volume: 0.3);

    add(ParallaxBackground());
    add(Land());
    add(Mushroom());
    add(man);
    add(Score());
  }
}
