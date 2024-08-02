import 'dart:math';

import '../entities/game_data.dart';

abstract interface class MyCharacterRepository {
  const MyCharacterRepository();

  /// Moves a character on the map using the map's X and Y position.
  Future<GameData> actionMove(String characterName, Point<int> position);
}
