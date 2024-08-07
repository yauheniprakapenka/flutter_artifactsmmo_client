import 'dart:math';

import '../../characters/entities/character.dart';
import '../entities/game_data.dart';

abstract interface class MyCharacterRepository {
  const MyCharacterRepository();

  /// Moves a character on the map using the map's X and Y position.
  Future<GameData> actionMove(String characterName, Point<int> position);

  /// Start a fight against a monster on the character's map.
  Future<GameData> actionFight(String characterName);

  /// List of your characters.
  Future<List<Character>> getAllMyCharacters();
}
