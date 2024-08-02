import 'character.dart';
import 'cooldown.dart';
import 'destination.dart';

class GameData {
  final Cooldown cooldown;
  final Destination destination;
  final Character character;

  const GameData({
    required this.cooldown,
    required this.destination,
    required this.character,
  });
}
