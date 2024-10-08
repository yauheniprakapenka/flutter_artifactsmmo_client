import 'character_dto.dart';
import 'cooldown_dto.dart';
import 'destination_dto.dart';
import 'fight_dto.dart';
import 'reward_dto.dart';

class CharacterGameDataDto {
  final CharacterDto? character;
  final CooldownDto? cooldown;
  final DestinationDto? destination;
  final FightDto? fight;
  final RewardDto? reward;

  const CharacterGameDataDto({
    required this.character,
    required this.cooldown,
    required this.destination,
    required this.fight,
    required this.reward,
  });

  factory CharacterGameDataDto.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? character = json['character'];
    final Map<String, dynamic>? cooldown = json['cooldown'];
    final Map<String, dynamic>? destination = json['destination'];
    final Map<String, dynamic>? fight = json['fight'];
    final Map<String, dynamic>? reward = json['reward'];

    return CharacterGameDataDto(
      cooldown: cooldown == null ? null : CooldownDto.fromJson(cooldown),
      destination: destination == null ? null : DestinationDto.fromJson(destination),
      fight: fight == null ? null : FightDto.fromJson(fight),
      character: character == null ? null : CharacterDto.fromJson(character),
      reward: reward == null ? null : RewardDto.fromJson(reward),
    );
  }
}
