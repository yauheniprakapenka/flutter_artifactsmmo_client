part of 'world_bloc.dart';

abstract interface class WorldEvent {
  const WorldEvent();
}

final class InitialEvent implements WorldEvent {
  const InitialEvent();
}

final class ChangePositionEvent implements WorldEvent {
  final String characterName;
  final Point<int> position;

  const ChangePositionEvent(this.characterName, this.position);
}

final class SelectCharacterEvent implements WorldEvent {
  final Character character;

  const SelectCharacterEvent(this.character);
}

final class AddCharacterEvent implements WorldEvent {
  const AddCharacterEvent();
}

final class FocusToSelectedCharacterEvent implements WorldEvent {
  const FocusToSelectedCharacterEvent();
}

final class SelectTileEvent implements WorldEvent {
  final Tile? tile;

  const SelectTileEvent(this.tile);
}

final class ShowGridEvent implements WorldEvent {
  const ShowGridEvent();
}

final class FightEvent implements WorldEvent {
  const FightEvent();
}