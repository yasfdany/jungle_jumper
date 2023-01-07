import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:jungle_jumper/r.dart';
import 'package:jungle_jumper/scenes/main_game_scene.dart';
import 'package:jungle_jumper/utils/extensions.dart';

class Mushroom extends SpriteComponent with HasGameRef<MainGameScene> {
  final double speed = 400;
  double groundPos = 0;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    groundPos = gameRef.size.y - 114;
    sprite = await Sprite.load(AssetImages.mushroom.fileName);
    size = Vector2(64, 68);
    anchor = Anchor.bottomLeft;
    position = Vector2(gameRef.size.x, groundPos);

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    x -= speed * dt;
    if (x <= -size.x) x = gameRef.size.x;
  }

  void reset() {
    x = gameRef.size.x;
  }
}
