import 'package:domain/domain.dart';

import '../dto/tile_dto.dart';
import 'tile_content_dto_mapper.dart';

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
