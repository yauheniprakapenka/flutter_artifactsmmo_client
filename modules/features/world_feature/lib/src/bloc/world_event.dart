part of 'world_bloc.dart';

abstract interface class WorldEvent {
  const WorldEvent();
}

final class InitialEvent implements WorldEvent {
  const InitialEvent();
}

// Actions

final class ActionFightEvent implements WorldEvent {
  final String characterName;

  const ActionFightEvent(this.characterName);
}

final class ActionMoveEvent implements WorldEvent {
  final String characterName;
  final Tile selectedTile;

  const ActionMoveEvent(this.characterName, this.selectedTile);
}

final class ActionTaskNewEvent implements WorldEvent {
  final String characterName;

  const ActionTaskNewEvent(this.characterName);
}

final class ActionTaskCompleteEvent implements WorldEvent {
  final String characterName;

  const ActionTaskCompleteEvent(this.characterName);
}

final class AutoFightEvent implements WorldEvent {
  final String characterName;
  final Tile autoFightOnTile;

  const AutoFightEvent(this.characterName, this.autoFightOnTile);
}

// Characters

final class FocusToSelectedCharacterEvent implements WorldEvent {
  const FocusToSelectedCharacterEvent();
}

final class SelectCharacterEvent implements WorldEvent {
  final Character character;

  const SelectCharacterEvent(this.character);
}

// Map

final class SelectTileEvent implements WorldEvent {
  final Tile? tile;

  const SelectTileEvent(this.tile);
}

final class ShowGridEvent implements WorldEvent {
  const ShowGridEvent();
}

final class SelectCharacterAttributeEvent implements WorldEvent {
  final CharacterAttribute selectedCharacterAttribute;

  const SelectCharacterAttributeEvent(this.selectedCharacterAttribute);
}
