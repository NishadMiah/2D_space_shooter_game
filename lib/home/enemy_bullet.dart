import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:aetherius/home/space_shooter_game.dart';
import 'package:flutter/material.dart';

/// A bullet fired by the Tank enemy downward toward the player.
/// Hitting the player reduces their bullet count by 1.
class EnemyBullet extends PositionComponent
    with CollisionCallbacks, HasGameReference<SpaceShooterGame> {
  EnemyBullet() : super(size: Vector2(10, 18), anchor: Anchor.center);

  final double speed = 280;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Orange outer glow
    add(
      RectangleComponent(
        size: Vector2(10, 18),
        paint: Paint()
          ..color = const Color(0xFFFF4400).withAlpha(200)
          ..style = PaintingStyle.fill,
      ),
    );
    // Bright white core
    add(
      RectangleComponent(
        size: Vector2(4, 12),
        position: Vector2(3, 3),
        paint: Paint()
          ..color = Colors.white.withAlpha(220)
          ..style = PaintingStyle.fill,
      ),
    );

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;
    if (position.y > game.size.y + 30) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other == game.player) {
      removeFromParent();
      game.onEnemyBulletHit();
    }
  }
}
