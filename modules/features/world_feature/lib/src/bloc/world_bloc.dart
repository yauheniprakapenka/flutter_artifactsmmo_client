import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../controllers/auto_fight_controller.dart';
import '../models/character_attribute.dart';

part 'world_state.dart';
part 'world_event.dart';

class WorldBloc extends Bloc<WorldEvent, WorldState> {
  final MyCharacterRepository _myCharacterRepository;
  final CharactersRepository _charactersRepository;
  final MapsRepository _mapsRepository;

  WorldBloc({
    required MyCharacterRepository myCharacterRepository,
    required CharactersRepository charactersRepository,
    required MapsRepository mapsRepository,
  })  : _myCharacterRepository = myCharacterRepository,
        _charactersRepository = charactersRepository,
        _mapsRepository = mapsRepository,
        super(WorldState.initial()) {
    on<ActionFightEvent>(_actionFight);
    on<ActionMoveEvent>(_actionMove);
    on<ActionTaskCompleteEvent>(_actionTaskComplete);
    on<ActionTaskNewEvent>(_actionTaskNew);
    on<AutoFightEvent>(_autoFight);
    on<FocusToSelectedCharacterEvent>(_focusToSelectedCharacter);
    on<InitialEvent>(_initial);
    on<SelectCharacterAttributeEvent>(_selectCharacterAttributeEvent);
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

      final Map<String, AutoFightController> autoFightControllers = {};
      characterGameDataList.forEach((CharacterGameData characterGameData) {
        autoFightControllers[characterGameData.character!.name] = AutoFightController(
          onActionFight: () {
            add(ActionFightEvent(characterGameData.character!.name));
          },
        );
      });

      emit(state.copyWith(
        characterGameDataList: characterGameDataList,
        mapDetails: () => mapDetails,
        autoFightControllers: autoFightControllers,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false, error: () => null));
    }
  }

  Future<void> _actionMove(ActionMoveEvent event, Emitter emit) async {
    try {
      final CharacterGameData updatedCharacterGameData = await _myCharacterRepository.actionMove(
        event.characterName,
        Point<int>(event.selectedTile.x, event.selectedTile.y),
      );
      _updateCharacters(emit, updatedCharacterGameData);
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(error: () => null));
    }
  }

  Future<void> _actionFight(ActionFightEvent event, Emitter emit) async {
    try {
      final CharacterGameData updatedCharacterGameData = await _myCharacterRepository.actionFight(event.characterName);
      _updateCharacters(emit, updatedCharacterGameData);
      _updateAutoFightController(updatedCharacterGameData);
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(error: () => null));
    }
  }

  Future<void> _autoFight(AutoFightEvent event, Emitter emit) async {
    final String characterName = event.characterName;
    final AutoFightController? autoFightController = state.autoFightControllers[characterName];
    if (autoFightController == null) {
      return;
    }

    if (autoFightController.isAutoFight) {
      autoFightController.stopAutoFight();
      emit(state.copyWith());
      return;
    }

    final Character character = await _charactersRepository.getCharactersByName(characterName);
    Duration cooldownExpiration = character.cooldownExpiration.difference(DateTime.now());
    if (cooldownExpiration.inSeconds < 1) {
      // A negative value indicates that the action has already occurred the specified amount of time ago.
      cooldownExpiration = const Duration(seconds: 1); // There is a slight delay before the timer starts. It works stably with a delay of more than 1 second.
    }
    autoFightController.setDelay(cooldownExpiration);
    autoFightController.startAutoFight(event.autoFightOnTile);
  }

  Future<void> _actionTaskNew(ActionTaskNewEvent event, Emitter emit) async {
    try {
      final CharacterGameData updatedCharacterGameData = await _myCharacterRepository.actionTaskNew(event.characterName);
      _updateCharacters(emit, updatedCharacterGameData);
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(error: () => null));
    }
  }

  Future<void> _actionTaskComplete(ActionTaskCompleteEvent event, Emitter emit) async {
    try {
      final CharacterGameData updatedCharacterGameData = await _myCharacterRepository.actionTaskComplete(event.characterName);
      _updateCharacters(emit, updatedCharacterGameData);
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(error: () => null));
    }
  }

  void _updateAutoFightController(CharacterGameData characterGameData) {
    final Character? character = characterGameData.character;
    if (character == null) {
      return;
    }

    final AutoFightController? autoFightController = state.autoFightControllers[character.name];
    if (autoFightController == null) {
      return;
    }

    if (autoFightController.isAutoFight) {
      const Duration additionalDelay = Duration(seconds: 1); // The server returns an incorrect time, you need to wait some more.
      final Duration delayInSeconds = character.cooldownExpiration.difference(DateTime.now()) + additionalDelay;
      autoFightController.setDelay(delayInSeconds);
    }
  }

  // Future<void> _getGameData(GetGameDataEvent event, Emitter emit) async {
  //   final MapDetails mapDetails = await _mapsRepository.getAllMaps();

  //   final List<Character> characters = await _myCharacterRepository.getAllMyCharacters();
  //   final List<CharacterGameData> characterGameDataList = [
  //     ...characters.map((Character character) => CharacterGameData(character: character)),
  //   ];

  //   emit(state.copyWith(
  //     characterGameDataList: characterGameDataList,
  //     mapDetails: () => mapDetails,
  //   ));
  // }

  void _updateCharacters(Emitter emit, CharacterGameData updatedCharacterGameData) {
    // Update character list

    final List<CharacterGameData> characterGameDataList = [...state.characterGameDataList];
    final int updatedCharacterGameDataIndex = characterGameDataList.indexWhere((gameData) {
      return gameData.character?.name == updatedCharacterGameData.character?.name;
    });
    characterGameDataList[updatedCharacterGameDataIndex] = updatedCharacterGameData;

    // Update selected character

    final int selectedCharacterIndex = characterGameDataList.indexWhere((gameData) {
      return gameData.character?.name == state.selectedCharacter?.name;
    });
    final CharacterGameData updatedSelectedCharacter = characterGameDataList[selectedCharacterIndex];

    emit(state.copyWith(
      characterGameDataList: characterGameDataList,
      selectedCharacter: () => updatedSelectedCharacter.character,
    ));
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

  void _selectCharacterAttributeEvent(SelectCharacterAttributeEvent event, Emitter emit) {
    if (state.selectedCharacterAttribute == event.selectedCharacterAttribute) {
      emit(state.copyWith(selectedCharacterAttribute: CharacterAttribute.none));
      return;
    }
    emit(state.copyWith(selectedCharacterAttribute: event.selectedCharacterAttribute));
  }
}
