import 'package:domain/domain.dart';

import '../dto/cooldown_dto.dart';

extension CooldownDtoMapper on CooldownDto {
  Cooldown get asDomain {
    return Cooldown(
      totalSeconds: totalSeconds,
      remainingSeconds: remainingSeconds,
      expiration: expiration,
      reason: reason,
    );
  }
}
