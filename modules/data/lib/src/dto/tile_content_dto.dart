import 'tile_conten_type_dto.dart';

class TileContentDto {
  final TileContentTypeDto type;
  final String code;

  const TileContentDto({
    required this.type,
    required this.code,
  });

  factory TileContentDto.fromMap(Map<String, dynamic> json) {
    return TileContentDto(
      type: TileContentTypeDto.fromType(json['type']),
      code: json['code'],
    );
  }
}
