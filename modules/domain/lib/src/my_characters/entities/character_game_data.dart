import '../../characters/entities/character.dart';
import 'cooldown.dart';
import 'destination.dart';
import 'fight.dart';

class CharacterGameData {
  final Character? character;
  final Cooldown? cooldown;
  final Destination? destination;
  final Fight? fight;

  final bool isActionAvailable;

  const CharacterGameData({
    required this.character,
    this.cooldown,
    this.destination,
    this.fight,
    this.isActionAvailable = true,
  });
}
