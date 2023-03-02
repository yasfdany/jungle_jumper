import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:jungle_jumper/components/mushroom.dart';
import 'package:jungle_jumper/r.dart';
import 'package:jungle_jumper/scenes/main_game_scene.dart';
import 'package:jungle_jumper/utils/extensions.dart';

import '../main.dart';
import '../state/main_game_state.dart';

enum ManState {
  running,
  jump,
  landing,
}

class Man extends SpriteAnimationGroupComponent<ManState>
    with HasGameRef<MainGameScene>, CollisionCallbacks {
  final mainGameState = getIt<MainGameState>();
  final double gravity = 1;

  final double initialJumpVelocity = -15.0;
  final double introDuration = 1500.0;
  final double startXPosition = 50;
  double jumpVelocity = 0.0;

  double groundPos = 0;

  late SpriteAnimation runningAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation landingAnimation;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    groundPos = gameRef.size.y - 114;
    anchor = Anchor.bottomLeft;
    position = Vector2(128, groundPos);

    await _loadRunningAnimation();
    await _loadJumpAnimation();
    await _loadLandingAnimation();

    animations = {
      ManState.running: runningAnimation,
      ManState.jump: jumpAnimation,
      ManState.landing: landingAnimation,
    };
    current = ManState.running;

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch (current) {
      case ManState.running:
        size = Vector2(105, 165);
        break;
      case ManState.jump:
        size = Vector2(85, 170);
        break;
      case ManState.landing:
        size = Vector2(100, 175);
        break;
      default:
        break;
    }

    if (current == ManState.jump || current == ManState.landing) {
      y += jumpVelocity;
      jumpVelocity += gravity;
      if (!jumpVelocity.isNegative) {
        current = ManState.landing;
      }

      if (y > groundPos) {
        reset();
      }
    } else {
      y = groundPos;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Mushroom) gameOver();
    super.onCollision(intersectionPoints, other);
  }

  void gameOver() {
    gameRef.camera.shake(intensity: 6);
    FlameAudio.play(AssetAudio.hit.fileName, volume: 0.5);
    FlameAudio.bgm.stop();
    game.pauseEngine();

    mainGameState.setGameOver(true);
    mainGameState.checkHighScore();
    game.overlays.add('game_over');
  }

  void jump() {
    if (current == ManState.jump ||
        current == ManState.landing ||
        mainGameState.isPause) {
      return;
    }

    current = ManState.jump;
    jumpVelocity = initialJumpVelocity - 8;
    FlameAudio.play(AssetAudio.jump.fileName, volume: 0.5);
  }

  void reset() {
    y = groundPos;
    jumpVelocity = 0.0;
    current = ManState.running;
  }

  Future _loadRunningAnimation() async {
    final runningSprites = List.generate(8, (i) => 'run_$i.png').map(
      (name) => Sprite.load(name),
    );

    runningAnimation = SpriteAnimation.spriteList(
      await Future.wait(runningSprites),
      stepTime: 0.1,
    );
  }

  Future _loadJumpAnimation() async {
    final jumpSprite = await Sprite.load(AssetImages.jump.fileName);

    jumpAnimation = SpriteAnimation.spriteList(
      [jumpSprite],
      stepTime: 0.1,
    );
  }

  Future _loadLandingAnimation() async {
    final landingSprite = await Sprite.load(AssetImages.landing.fileName);

    landingAnimation = SpriteAnimation.spriteList(
      [landingSprite],
      stepTime: 0.1,
    );
  }
}
