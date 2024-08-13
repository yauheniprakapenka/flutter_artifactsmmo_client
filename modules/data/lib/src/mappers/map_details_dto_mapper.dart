import 'package:domain/domain.dart';

import '../dto/map_details_dto.dart';
import '../dto/tile_dto.dart';
import 'tile_dto_mapper.dart';

extension MapDtoMapper on MapDetailsDto {
  MapDetails get asDomain {
    return MapDetails(
      tiles: tiles.map((TileDto tileDto) => tileDto.asDomain).toList(),
      total: total,
      page: page,
      size: size,
      pages: pages,
    );
  }
}
