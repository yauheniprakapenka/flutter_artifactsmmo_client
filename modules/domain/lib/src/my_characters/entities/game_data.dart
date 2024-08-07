import '../../characters/entities/character.dart';
import 'cooldown.dart';
import 'destination.dart';
import 'fight.dart';

class GameData {
  final Character? character;
  final Cooldown? cooldown;
  final Destination? destination;
  final Fight? fight;

  const GameData({
    required this.character,
    required this.cooldown,
    required this.destination,
    required this.fight,
  });
}
