import 'package:domain/domain.dart';

import '../dto/tile_conten_type_dto.dart';

extension ContentTypeDtoMapper on TileContentTypeDto {
  TileContentType get asDomain {
    switch (this) {
      case TileContentTypeDto.bank:
        return TileContentType.bank;
      case TileContentTypeDto.monster:
        return TileContentType.monster;
      case TileContentTypeDto.resource:
        return TileContentType.resource;
      case TileContentTypeDto.tasks_master:
        return TileContentType.tasks_master;
      case TileContentTypeDto.workshop:
        return TileContentType.workshop;
      case TileContentTypeDto.grand_exchange:
        return TileContentType.grand_exchange;
      case TileContentTypeDto.unknown:
        return TileContentType.unknown;
    }
  }
}
