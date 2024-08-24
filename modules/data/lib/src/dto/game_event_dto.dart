import 'tile_dto.dart';

class GameEventDto {
  final DateTime createdAt;
  final DateTime expiration;
  final int duration;
  final String name;
  final String previousSkin;
  final TileDto tile;

  const GameEventDto({
    required this.createdAt,
    required this.duration,
    required this.expiration,
    required this.name,
    required this.previousSkin,
    required this.tile,
  });

  factory GameEventDto.fromJson(Map<String, dynamic> json) {
    return GameEventDto(
      createdAt: DateTime.parse(json['created_at']),
      duration: json['duration'],
      expiration: DateTime.parse(json['expiration']),
      name: json['name'],
      previousSkin: json['previous_skin'],
      tile: TileDto.fromMap(json['map']),
    );
  }
}
