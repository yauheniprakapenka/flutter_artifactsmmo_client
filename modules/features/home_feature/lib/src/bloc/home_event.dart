part of 'home_bloc.dart';

abstract interface class HomeEvent {
  const HomeEvent();
}

final class ChangePositionEvent implements HomeEvent {
  final String characterName;
  final Point<int> position;

  const ChangePositionEvent(this.characterName, this.position);
}
