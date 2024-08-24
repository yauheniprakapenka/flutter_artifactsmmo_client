part of 'world_bloc.dart';

class WorldState {
  final bool focusToSelectedCharacter;
  final bool isLoading;
  final bool showGrid;
  final Character? selectedCharacter;
  final CharacterAttribute selectedCharacterAttribute;
  final List<CharacterGameData> characterGameDataList;
  final List<GameEvent> gameEvents;
  final MapDetails? mapDetails;
  final String? error;
  final Tile? selectedTile;

  /// `String` - name of character.
  final Map<String, AutoFightController> autoFightControllers;
  final GameEventsController? gameEventsController;

  AutoFightController? getAutoFightController(String characterName) {
    return autoFightControllers[characterName];
  }

  const WorldState({
    required this.autoFightControllers,
    required this.characterGameDataList,
    required this.error,
    required this.focusToSelectedCharacter,
    required this.gameEvents,
    required this.gameEventsController,
    required this.isLoading,
    required this.mapDetails,
    required this.selectedCharacter,
    required this.selectedCharacterAttribute,
    required this.selectedTile,
    required this.showGrid,
  });

  factory WorldState.initial() {
    return const WorldState(
      gameEventsController: null,
      characterGameDataList: [],
      error: null,
      focusToSelectedCharacter: false,
      isLoading: true,
      mapDetails: null,
      selectedCharacter: null,
      selectedTile: null,
      showGrid: false,
      autoFightControllers: {},
      selectedCharacterAttribute: CharacterAttribute.none,
      gameEvents: [],
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
    CharacterAttribute? selectedCharacterAttribute,
    List<GameEvent>? gameEvents,
    ValueGetter<GameEventsController?>? gameEventsController,
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
      selectedCharacterAttribute: selectedCharacterAttribute ?? this.selectedCharacterAttribute,
      gameEvents: gameEvents ?? this.gameEvents,
      gameEventsController: gameEventsController != null ? gameEventsController() : this.gameEventsController,
    );
  }
}
