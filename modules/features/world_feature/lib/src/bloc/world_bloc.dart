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
    on<ChangePositionEvent>(_changePositionMove);
    on<InitialEvent>(_initial);
    on<SelectCharacterEvent>(_selectCharacter);
    on<FocusToSelectedCharacterEvent>(_focusToSelectedCharacter);
    on<SelectTileEvent>(_selectTile);
    on<ShowGridEvent>(_showGrid);
    on<FightEvent>(_fight);
    add(const InitialEvent());
  }

  Future<void> _initial(InitialEvent event, Emitter emit) async {
    try {
      final MapDetails mapDetails = await _mapsRepository.getAllMaps();
      final List<Character> characters = await _myCharacterRepository.getAllMyCharacters();
      final Character? selectedCharacter = characters.isEmpty ? null : characters.first;
      emit(state.copyWith(
        characters: characters,
        selectedCharacter: () => selectedCharacter,
        mapDetails: () => mapDetails,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false, error: () => null));
    }
  }

  Future<void> _changePositionMove(ChangePositionEvent event, Emitter emit) async {
    emit(state.copyWith(isChangingPositon: true));
    try {
      await _myCharacterRepository.actionMove(
        event.characterName,
        event.position,
      );
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(isChangingPositon: false, error: () => null));
    }
  }

  Future<void> _fight(FightEvent event, Emitter emit) async {
    final String? selectedCharacterName = state.selectedCharacter?.name;
    if (selectedCharacterName == null) {
      return;
    }
    try {
      final GameData gameData = await _myCharacterRepository.actionFight(selectedCharacterName);
      print(gameData);
    }
     on Exception catch (e) {
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
    emit(state.copyWith(selectedCharacter: () => event.character));
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
