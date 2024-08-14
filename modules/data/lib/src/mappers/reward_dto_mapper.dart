import 'package:domain/domain.dart';

import '../dto/reward_dto.dart';

extension RewardDtoMapper on RewardDto {
  Reward get asDomain {
    return Reward(
      code: code,
      quantity: quantity,
    );
  }
}