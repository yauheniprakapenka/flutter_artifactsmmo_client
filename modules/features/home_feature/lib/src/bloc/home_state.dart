part of 'home_bloc.dart';

class HomeState {
  final bool isChangingPositon;
  final bool isLoading;
  final GameData? gameData;
  final Point<int>? newPosition;
  final String? error;

  const HomeState({
    required this.error,
    required this.gameData,
    required this.isChangingPositon,
    required this.isLoading,
    required this.newPosition,
  });

  factory HomeState.initial() {
    return const HomeState(
      error: null,
      gameData: null,
      isChangingPositon: false,
      isLoading: true,
      newPosition: null,
    );
  }

  HomeState copyWith({
    ValueGetter<GameData?>? gameData,
    bool? isLoading,
    bool? isChangingPositon,
    ValueGetter<String?>? error,
    ValueGetter<Point<int>?>? newPosition,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      gameData: gameData != null ? gameData() : this.gameData,
      isChangingPositon: isChangingPositon ?? this.isChangingPositon,
      error: error != null ? error() : this.error,
      newPosition: newPosition != null ? newPosition() : this.newPosition,
    );
  }
}
