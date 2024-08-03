import 'package:domain/domain.dart';

import '../dto/game_data_dto.dart';
import 'character_dto_mapper.dart';
import 'cooldawn_dto_mapper.dart';
import 'destination_dto_mapper.dart';

extension GameDataDtoMapper on GameDataDto {
  GameData get asDomain {
    return GameData(
      cooldown: cooldown.asDomain,
      destination: destination.asDomain,
      character: character.asDomain,
    );
  }
}