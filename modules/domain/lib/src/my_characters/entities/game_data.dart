import '../../characters/entities/character.dart';
import 'cooldown.dart';
import 'destination.dart';

class GameData {
  final Cooldown? cooldown;
  final Destination? destination;
  final Character? character;

  const GameData({
    this.cooldown,
    this.destination,
    required this.character,
  });
}
