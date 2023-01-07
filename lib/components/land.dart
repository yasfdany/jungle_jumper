import 'dart:collection';

import 'package:flame/components.dart';
import 'package:jungle_jumper/r.dart';
import 'package:jungle_jumper/scenes/main_game_scene.dart';
import 'package:jungle_jumper/utils/extensions.dart';

class Land extends PositionComponent with HasGameRef<MainGameScene> {
  final Queue<SpriteComponent> lands = Queue();
  int tileCount = 0;
  double spriteSize = 128;
  double speed = 400;

  Sprite? landSprite;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    landSprite = await Sprite.load(AssetImages.land.fileName);
    tileCount = (gameRef.size.x ~/ 128) + 1;
    y = gameRef.size.y;

    lands.addAll(generateLands());
    addAll(lands);
  }

  @override
  void update(double dt) {
    super.update(dt);
    for (final land in lands) {
      land.x -= speed * dt;
    }

    final firstLand = lands.first;
    if (firstLand.x <= -firstLand.width) {
      firstLand.x = lands.last.x + lands.last.width;
      lands.remove(firstLand);
      lands.add(firstLand);
    }
  }

  List<SpriteComponent> generateLands() {
    return List.generate(tileCount, (i) {
      return SpriteComponent(
        sprite: landSprite,
        size: Vector2(spriteSize, spriteSize),
        position: Vector2(i * spriteSize, 0),
        anchor: Anchor.bottomLeft,
      );
    }, growable: true);
  }
}
