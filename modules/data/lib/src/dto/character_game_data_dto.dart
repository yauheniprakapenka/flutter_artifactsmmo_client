import 'character_dto.dart';
import 'cooldown_dto.dart';
import 'destination_dto.dart';
import 'fight_dto.dart';

class CharacterGameDataDto {
  final CharacterDto character;
  final CooldownDto cooldown;
  final DestinationDto? destination;
  final FightDto? fight;

  const CharacterGameDataDto({
    required this.character,
    required this.cooldown,
    required this.destination,
    required this.fight,
  });

  factory CharacterGameDataDto.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? destination = json['destination'];

    return CharacterGameDataDto(
      cooldown: CooldownDto.fromJson(json['cooldown']),
      destination: destination == null ? null : DestinationDto.fromJson(destination),
      fight: FightDto.fromJson(json['fight']),
      character: CharacterDto.fromJson(json['character']),
    );
  }
}
