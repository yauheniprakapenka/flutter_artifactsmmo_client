import 'dart:math';

abstract interface class MyCharacterRepository {
  const MyCharacterRepository();

  Future<void> actionMove(String characterName, Point<int> position);
}
