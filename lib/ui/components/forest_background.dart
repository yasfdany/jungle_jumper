import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:jungle_jumper/utils/extensions.dart';

import '../../r.dart';

class ForestBackground extends FlameGame {
  @override
  Future<void>? onLoad() {
    add(ParralaxForest());
    return super.onLoad();
  }
}

class ParralaxForest extends ParallaxComponent<ForestBackground> {
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

  @override
  void update(double dt) {
    super.update(dt);
  }
}
