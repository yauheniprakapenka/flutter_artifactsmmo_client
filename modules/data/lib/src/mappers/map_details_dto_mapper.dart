import 'package:domain/domain.dart';

import '../dto/tile_dto.dart';

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

extension TileDtoMapper on TileDto {
  Tile get asDomain {
    return Tile(
      name: name,
      skin: skin,
      x: x,
      y: y,
      content: content?.asDomain,
    );
  }
}

extension TileContentDtoMapper on TileContentDto {
  TileContent get asDomain {
    return TileContent(
      type: type,
      code: code,
    );
  }
}
