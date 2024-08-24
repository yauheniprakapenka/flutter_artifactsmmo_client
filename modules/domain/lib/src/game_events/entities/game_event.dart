import '../../maps/entities/map_details.dart';

class GameEvent {
  final String name;
  final String previousSkin;
  final int duration;
  final DateTime expiration;
  final DateTime createdAt;
  final Tile tile;

  const GameEvent({
    required this.name,
    required this.previousSkin,
    required this.duration,
    required this.expiration,
    required this.createdAt,
    required this.tile,
  });
}
