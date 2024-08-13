import 'package:domain/domain.dart';

import '../dto/tile_content_dto.dart';
import 'content_type_dto_mapper.dart';

extension TileContentDtoMapper on TileContentDto {
  TileContent get asDomain {
    return TileContent(
      type: type.asDomain,
      code: code,
    );
  }
}
