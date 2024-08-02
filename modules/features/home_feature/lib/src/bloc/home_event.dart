part of 'home_bloc.dart';

abstract interface class HomeEvent {
  const HomeEvent();
}

final class InitialEvent implements HomeEvent {
  const InitialEvent();
}

final class ChangePositionMoveEvent implements HomeEvent {
  const ChangePositionMoveEvent();
}

final class ChangePositionXIncrementEvent implements HomeEvent {
  const ChangePositionXIncrementEvent();
}

final class ChangePositionXDecrementEvent implements HomeEvent {
  const ChangePositionXDecrementEvent();
}

final class ChangePositionYIncrementEvent implements HomeEvent {
  const ChangePositionYIncrementEvent();
}

final class ChangePositionYDecrementEvent implements HomeEvent {
  const ChangePositionYDecrementEvent();
}
