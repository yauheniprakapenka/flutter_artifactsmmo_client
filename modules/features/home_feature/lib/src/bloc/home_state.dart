part of 'home_bloc.dart';

class HomeState {
  final GameData? gameData;
  final bool isChangingPositon;
  final String? error;
  final Point<int>? newPosition;

  const HomeState({
    required this.gameData,
    required this.isChangingPositon,
    required this.error,
    required this.newPosition,
  });

  factory HomeState.initial() {
    return const HomeState(
      gameData: null,
      isChangingPositon: false,
      error: null,
      newPosition: null,
    );
  }

  HomeState copyWith({
    ValueGetter<GameData?>? gameData,
    bool? isChangingPositon,
    ValueGetter<String?>? error,
    ValueGetter<Point<int>?>? newPosition,
  }) {
    return HomeState(
      gameData: gameData != null ? gameData() : this.gameData,
      isChangingPositon: isChangingPositon ?? this.isChangingPositon,
      error: error != null ? error() : this.error,
      newPosition: newPosition != null ? newPosition() : this.newPosition,
    );
  }
}
