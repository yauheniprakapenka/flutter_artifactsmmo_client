import 'tile_content_dto.dart';

class TileDto {
  final String name;
  final String skin;
  final int x;
  final int y;
  final TileContentDto? content;

  const TileDto({
    required this.name,
    required this.skin,
    required this.x,
    required this.y,
    this.content,
  });

  factory TileDto.fromMap(Map<String, dynamic> json) {
    return TileDto(
      name: json['name'],
      skin: json['skin'],
      x: json['x'],
      y: json['y'],
      content: json['content'] == null ? null : TileContentDto.fromMap(json['content']),
    );
  }
}
