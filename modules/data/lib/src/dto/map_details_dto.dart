import 'tile_dto.dart';

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
