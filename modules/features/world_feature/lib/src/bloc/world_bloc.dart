import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

part 'world_state.dart';
part 'world_event.dart';

class WorldBloc extends Bloc<WorldEvent, WorldState> {
  final MyCharacterRepository _myCharacterRepository;
  final MapsRepository _mapsRepository;

  WorldBloc({
    required MyCharacterRepository myCharacterRepository,
    required MapsRepository mapsRepository,
  })  : _myCharacterRepository = myCharacterRepository,
        _mapsRepository = mapsRepository,
        super(WorldState.initial()) {
    on<InitialEvent>(_initial);
    on<ActionFightEvent>(_actionFight);
    on<ActionMoveEvent>(_actionMove);
    on<FocusToSelectedCharacterEvent>(_focusToSelectedCharacter);
    on<SelectCharacterEvent>(_selectCharacter);
    on<SelectTileEvent>(_selectTile);
    on<ShowGridEvent>(_showGrid);
    add(const InitialEvent());
  }

  Future<void> _initial(InitialEvent event, Emitter emit) async {
    try {
      final MapDetails mapDetails = await _mapsRepository.getAllMaps();
      final List<Character> characters = await _myCharacterRepository.getAllMyCharacters();
      final List<CharacterGameData> characterGameDataList = [
        ...characters.map((Character character) => CharacterGameData(character: character)),
      ];
      emit(state.copyWith(
        characterGameDataList: characterGameDataList,
        mapDetails: () => mapDetails,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false, error: () => null));
    }
  }

  Future<void> _actionMove(ActionMoveEvent event, Emitter emit) async {
    try {
      final CharacterGameData characterGameData = await _myCharacterRepository.actionMove(
        event.characterName,
        Point<int>(event.selectedTile.x, event.selectedTile.y),
      );
      final List<CharacterGameData> characterGameDataList = [...state.characterGameDataList];
      final int index = characterGameDataList.indexWhere((gameData) {
        return gameData.character?.name == characterGameData.character?.name;
      });
      characterGameDataList[index] = characterGameData;
      emit(state.copyWith(
        characterGameDataList: characterGameDataList,
        selectedCharacter: () => characterGameData.character,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(error: () => null));
    }
  }

  Future<void> _actionFight(ActionFightEvent event, Emitter emit) async {
    final String? selectedCharacterName = state.selectedCharacter?.name;
    if (selectedCharacterName == null) {
      return;
    }
    try {
      final CharacterGameData characterGameData = await _myCharacterRepository.actionFight(selectedCharacterName);
      final List<CharacterGameData> characterGameDataList = [...state.characterGameDataList];
      final int index = characterGameDataList.indexWhere((gameData) {
        return gameData.character?.name == characterGameData.character?.name;
      });
      characterGameDataList[index] = characterGameData;
      emit(state.copyWith(
        characterGameDataList: characterGameDataList,
        selectedCharacter: () => characterGameData.character,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(error: () => null));
    }
  }

  void _selectCharacter(SelectCharacterEvent event, Emitter emit) {
    if (state.selectedCharacter?.name == event.character.name) {
      emit(state.copyWith(selectedCharacter: () => null));
      return;
    }
    emit(state.copyWith(selectedCharacter: () => event.character, selectedTile: () => null));
  }

  void _focusToSelectedCharacter(FocusToSelectedCharacterEvent event, Emitter emit) {
    emit(state.copyWith(focusToSelectedCharacter: true));
    emit(state.copyWith(focusToSelectedCharacter: false));
  }

  void _selectTile(SelectTileEvent event, Emitter emit) {
    if (state.selectedTile == event.tile) {
      emit(state.copyWith(selectedTile: () => null));
      return;
    }
    emit(state.copyWith(selectedTile: () => event.tile));
  }

  void _showGrid(ShowGridEvent event, Emitter emit) {
    emit(state.copyWith(showGrid: !state.showGrid));
  }
}
