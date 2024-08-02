import 'character_dto.dart';
import 'cooldown_dto.dart';
import 'destination_dto.dart';

class GameDataDto {
  final CooldownDto cooldown;
  final DestinationDto destination;
  final CharacterDto character;

  const GameDataDto({
    required this.cooldown,
    required this.destination,
    required this.character,
  });

  factory GameDataDto.fromJson(Map<String, dynamic> json) {
    return GameDataDto(
      cooldown: CooldownDto.fromJson(json['cooldown']),
      destination: DestinationDto.fromJson(json['destination']),
      character: CharacterDto.fromJson(json['character']),
    );
  }
}
