import 'dart:math';

abstract interface class MyCharacterRepository {
  const MyCharacterRepository();

  /// Moves a character on the map using the map's X and Y position.
  Future<void> actionMove(String characterName, Point<int> position);
}
