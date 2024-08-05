import 'dart:developer';

class MapDetailsDto {
  final List<TileDto> tiles;
  final int total;
  final int page;
  final int size;
  final int pages;

  const MapDetailsDto({
    required this.tiles,
    required this.total,
    required this.page,
    required this.size,
    required this.pages,
  });

  factory MapDetailsDto.fromMap(Map<String, dynamic> json) {
    return MapDetailsDto(
      tiles: List<TileDto>.from(json['data'].map((x) => TileDto.fromMap(x))),
      total: json['total'],
      page: json['page'],
      size: json['size'],
      pages: json['pages'],
    );
  }
}

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

class TileContentDto {
  final TileContenTypetDto type;
  final String code;

  const TileContentDto({
    required this.type,
    required this.code,
  });

  factory TileContentDto.fromMap(Map<String, dynamic> json) {
    return TileContentDto(
      type: TileContenTypetDto.fromType(json['type']),
      code: json['code'],
    );
  }
}

enum TileContenTypetDto {
  bank('bank'),
  grand_exchange('grand_exchange'),
  monster('monster'),
  resource('resource'),
  tasks_master('tasks_master'),
  workshop('workshop'),
  unknown('unknown');

  final String type;

  const TileContenTypetDto(this.type);

  factory TileContenTypetDto.fromType(String type) {
    return TileContenTypetDto.values.firstWhere((TileContenTypetDto element) {
      return element.type.toLowerCase() == type.toLowerCase();
    }, orElse: () {
      log('Unknown tile content type: $type');
      return TileContenTypetDto.unknown;
    });
  }
}
