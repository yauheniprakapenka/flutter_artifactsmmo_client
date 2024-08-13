part of 'world_bloc.dart';

class WorldState {
  final bool focusToSelectedCharacter;
  final bool isLoading;
  final bool showGrid;
  final Character? selectedCharacter;
  final List<CharacterGameData> characterGameDataList;
  final MapDetails? mapDetails;
  final String? error;
  final Tile? selectedTile;

  /// `String` - name of character.
  final Map<String, AutoFightController> autoFightControllers;

  AutoFightController? getAutoFightController(String characterName) {
    return autoFightControllers[characterName];
  }

  const WorldState({
    required this.autoFightControllers,
    required this.characterGameDataList,
    required this.error,
    required this.focusToSelectedCharacter,
    required this.isLoading,
    required this.mapDetails,
    required this.selectedCharacter,
    required this.selectedTile,
    required this.showGrid,
  });

  factory WorldState.initial() {
    return const WorldState(
      characterGameDataList: [],
      error: null,
      focusToSelectedCharacter: false,
      isLoading: true,
      mapDetails: null,
      selectedCharacter: null,
      selectedTile: null,
      showGrid: false,
      autoFightControllers: {},
    );
  }

  WorldState copyWith({
    bool? focusToSelectedCharacter,
    bool? isLoading,
    bool? showGrid,
    ValueGetter<Character?>? selectedCharacter,
    List<CharacterGameData>? characterGameDataList,
    ValueGetter<MapDetails?>? mapDetails,
    ValueGetter<String?>? error,
    ValueGetter<Tile?>? selectedTile,
    Map<String, AutoFightController>? autoFightControllers,
  }) {
    return WorldState(
      focusToSelectedCharacter: focusToSelectedCharacter ?? this.focusToSelectedCharacter,
      isLoading: isLoading ?? this.isLoading,
      showGrid: showGrid ?? this.showGrid,
      selectedCharacter: selectedCharacter != null ? selectedCharacter() : this.selectedCharacter,
      characterGameDataList: characterGameDataList ?? this.characterGameDataList,
      mapDetails: mapDetails != null ? mapDetails() : this.mapDetails,
      error: error != null ? error() : this.error,
      selectedTile: selectedTile != null ? selectedTile() : this.selectedTile,
      autoFightControllers: autoFightControllers ?? this.autoFightControllers,
    );
  }
}
