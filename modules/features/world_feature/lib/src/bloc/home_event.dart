part of 'home_bloc.dart';

abstract interface class HomeEvent {
  const HomeEvent();
}

final class InitialEvent implements HomeEvent {
  const InitialEvent();
}

final class ChangePositionEvent implements HomeEvent {
  final String characterName;
  final Point<int> position;

  const ChangePositionEvent(this.characterName, this.position);
}

final class SelectCharacterEvent implements HomeEvent {
  final Character character;

  const SelectCharacterEvent(this.character);
}

final class AddCharacterEvent implements HomeEvent {
  const AddCharacterEvent();
}

final class FocusToSelectedCharacterEvent implements HomeEvent {
  const FocusToSelectedCharacterEvent();
}
