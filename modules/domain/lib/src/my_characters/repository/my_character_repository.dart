import 'dart:math';

import '../../characters/entities/character.dart';
import '../entities/character_game_data.dart';

abstract interface class MyCharacterRepository {
  const MyCharacterRepository();

  /// Moves a character on the map using the map's X and Y position.
  Future<CharacterGameData> actionMove(String characterName, Point<int> position);

  /// Start a fight against a monster on the character's map.
  Future<CharacterGameData> actionFight(String characterName);

  /// Action Accept New Task.
  Future<CharacterGameData> actionTaskNew(String characterName);

  /// Complete a task.
  Future<CharacterGameData> actionTaskComplete(String characterName);

  /// List of your characters.
  Future<List<Character>> getAllMyCharacters();
}
