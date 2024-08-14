import 'package:domain/domain.dart';

import '../dto/character_game_data_dto.dart';
import 'character_dto_mapper.dart';
import 'cooldown_dto_mapper.dart';
import 'destination_dto_mapper.dart';
import 'fight_dto_mapper.dart';
import 'reward_dto_mapper.dart';

extension GameDataDtoMapper on CharacterGameDataDto {
  CharacterGameData get asDomain {
    return CharacterGameData(
      cooldown: cooldown?.asDomain,
      destination: destination?.asDomain,
      character: character?.asDomain,
      fight: fight?.asDomain,
      reward: reward?.asDomain,
    );
  }
}
