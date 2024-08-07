import 'package:domain/domain.dart';

import '../dto/cooldown_dto.dart';

extension CooldownDtoMapper on CooldownDto {
  Cooldown get asDomain {
    return Cooldown(
      expiration: expiration,
      reason: reason,
      remainingSeconds: remainingSeconds,
      startedAt: startedAt,
      totalSeconds: totalSeconds,
    );
  }
}
