part of 'home_bloc.dart';

class HomeState {
  final bool focusToSelectedCharacter;
  final bool isChangingPositon;
  final bool isLoading;
  final bool showGrid;
  final Character? selectedCharacter;
  final List<Character> characters;
  final MapDetails? mapDetails;
  final String? error;
  final Tile? selectedTile;

  const HomeState({
    required this.characters,
    required this.error,
    required this.focusToSelectedCharacter,
    required this.isChangingPositon,
    required this.isLoading,
    required this.mapDetails,
    required this.selectedCharacter,
    required this.selectedTile,
    required this.showGrid,
  });

  factory HomeState.initial() {
    return const HomeState(
      characters: [],
      error: null,
      focusToSelectedCharacter: false,
      isChangingPositon: false,
      isLoading: true,
      mapDetails: null,
      selectedCharacter: null,
      selectedTile: null,
      showGrid: false,
    );
  }

  HomeState copyWith({
    bool? focusToSelectedCharacter,
    bool? isChangingPositon,
    bool? isLoading,
    bool? showGrid,
    ValueGetter<Character?>? selectedCharacter,
    List<Character>? characters,
    ValueGetter<MapDetails?>? mapDetails,
    ValueGetter<String?>? error,
    ValueGetter<Tile?>? selectedTile,
  }) {
    return HomeState(
      focusToSelectedCharacter: focusToSelectedCharacter ?? this.focusToSelectedCharacter,
      isChangingPositon: isChangingPositon ?? this.isChangingPositon,
      isLoading: isLoading ?? this.isLoading,
      showGrid: showGrid ?? this.showGrid,
      selectedCharacter: selectedCharacter != null ? selectedCharacter() : this.selectedCharacter,
      characters: characters ?? this.characters,
      mapDetails: mapDetails != null ? mapDetails() : this.mapDetails,
      error: error != null ? error() : this.error,
      selectedTile: selectedTile != null ? selectedTile() : this.selectedTile,
    );
  }
}
