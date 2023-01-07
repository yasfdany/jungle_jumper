import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:jungle_jumper/r.dart';
import 'package:jungle_jumper/scenes/main_game_scene.dart';
import 'package:jungle_jumper/utils/extensions.dart';

class ParallaxBackground extends ParallaxComponent<MainGameScene> {
  @override
  Future<void>? onLoad() async {
    super.onLoad();
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData(AssetImages.plx1.fileName),
        ParallaxImageData(AssetImages.plx2.fileName),
        ParallaxImageData(AssetImages.plx3.fileName),
        ParallaxImageData(AssetImages.plx4.fileName),
        ParallaxImageData(AssetImages.plx5.fileName),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
  }
}
