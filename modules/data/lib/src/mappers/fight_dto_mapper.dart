import 'package:domain/domain.dart';

import '../dto/fight_dto.dart';

extension FightDtoMapper on FightDto {
  Fight get asDomain {
    return Fight(
      xp: xp,
      gold: gold,
      drops: drops,
      turns: turns,
      monsterBlockedHits: monsterBlockedHits,
      playerBlockedHits: playerBlockedHits,
      logs: logs,
      result: result,
    );
  }
}
