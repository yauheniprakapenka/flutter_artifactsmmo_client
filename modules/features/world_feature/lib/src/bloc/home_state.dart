part of 'home_bloc.dart';

class HomeState {
  final bool isChangingPositon;
  final bool isLoading;
  final Character? selectedCharacter;
  final List<Character> characters;
  final MapDetails? mapDetails;
  final String? error;
  final bool focusToSelectedCharacter;

  const HomeState({
    required this.characters,
    required this.error,
    required this.isChangingPositon,
    required this.isLoading,
    required this.mapDetails,
    required this.selectedCharacter,
    required this.focusToSelectedCharacter,
  });

  factory HomeState.initial() {
    return const HomeState(
      characters: [],
      error: null,
      isChangingPositon: false,
      isLoading: true,
      mapDetails: null,
      selectedCharacter: null,
      focusToSelectedCharacter: false,
    );
  }

  HomeState copyWith({
    bool? isChangingPositon,
    bool? isLoading,
    ValueGetter<Character?>? selectedCharacter,
    List<Character>? characters,
    ValueGetter<MapDetails?>? mapDetails,
    ValueGetter<String?>? error,
    bool? focusToSelectedCharacter,
  }) {
    return HomeState(
      focusToSelectedCharacter: focusToSelectedCharacter ?? this.focusToSelectedCharacter,
      isChangingPositon: isChangingPositon ?? this.isChangingPositon,
      isLoading: isLoading ?? this.isLoading,
      selectedCharacter: selectedCharacter != null ? selectedCharacter() : this.selectedCharacter,
      characters: characters ?? this.characters,
      mapDetails: mapDetails != null ? mapDetails() : this.mapDetails,
      error: error != null ? error() : this.error,
    );
  }
}
