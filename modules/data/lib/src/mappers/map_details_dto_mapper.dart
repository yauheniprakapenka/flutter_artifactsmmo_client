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
      type: type.asDomain,
      code: code,
    );
  }
}

extension TileContentTypeDtoMapper on TileContenTypetDto {
  TileContentType get asDomain {
    switch (this) {
      case TileContenTypetDto.bank:
        return TileContentType.bank;
      case TileContenTypetDto.monster:
        return TileContentType.monster;
      case TileContenTypetDto.resource:
        return TileContentType.resource;
      case TileContenTypetDto.tasks_master:
        return TileContentType.tasks_master;
      case TileContenTypetDto.workshop:
        return TileContentType.workshop;
      case TileContenTypetDto.grand_exchange:
        return TileContentType.grand_exchange;
      case TileContenTypetDto.unknown:
        return TileContentType.unknown;
    }
  }
}
