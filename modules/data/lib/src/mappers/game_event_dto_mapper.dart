import 'package:domain/domain.dart';

import '../dto/game_event_dto.dart';
import 'tile_dto_mapper.dart';

extension GameEventDtoMapper on GameEventDto {
  GameEvent get asDomain {
    return GameEvent(
      name: name,
      previousSkin: previousSkin,
      duration: duration,
      expiration: expiration.toLocal(),
      createdAt: createdAt.toLocal(),
      tile: tile.asDomain,
    );
  }
}
