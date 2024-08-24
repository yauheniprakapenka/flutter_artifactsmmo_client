import 'dart:async';
import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../controllers/auto_fight_controller.dart';
import '../controllers/game_events_controller.dart';
import '../models/character_attribute.dart';

part 'world_state.dart';
part 'world_event.dart';

class WorldBloc extends Bloc<WorldEvent, WorldState> {
  final CharactersRepository _charactersRepository;
  final GameEventsRepository _gameEventsRepository;
  final MapsRepository _mapsRepository;
  final MyCharacterRepository _myCharacterRepository;

  AutoFightController? _autoFightControllerByName(String characterName) {
    return state.autoFightControllers[characterName];
  }

  WorldBloc({
    required CharactersRepository charactersRepository,
    required GameEventsRepository gameEventsRepository,
    required MapsRepository mapsRepository,
    required MyCharacterRepository myCharacterRepository,
  })  : _myCharacterRepository = myCharacterRepository,
        _charactersRepository = charactersRepository,
        _mapsRepository = mapsRepository,
        _gameEventsRepository = gameEventsRepository,
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
    on<GetGameEventsEvent>(_getGameEvents);
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

      final GameEventsController gameDataController = GameEventsController(
        onGameEvents: () async {
          add(const GetGameEventsEvent());
        },
      );

      emit(state.copyWith(
        characterGameDataList: characterGameDataList,
        mapDetails: () => mapDetails,
        autoFightControllers: autoFightControllers,
        gameEventsController: () => gameDataController,
      ));

      gameDataController.setDelay(const Duration(seconds: 1));
      gameDataController.startPeriodicGameUpdates();
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false, error: () => null));
    }
  }

  Future<void> _actionFight(ActionFightEvent event, Emitter emit) async {
    try {
      final CharacterGameData updatedCharacterGameData = await _myCharacterRepository.actionFight(event.characterName);
      _updateCharacters(emit, updatedCharacterGameData);
      _updateAutoFightController(updatedCharacterGameData);
    } on CharacterCooldownException catch (e) {
      emit(state.copyWith(error: () => e.message));
    } on AppException catch (e) {
      _autoFightControllerByName(event.characterName)?.stopAutoFight();
      emit(state.copyWith(error: () => '${e.message}\nAuto fight stopped.'));
    } on Exception catch (e) {
      _autoFightControllerByName(event.characterName)?.stopAutoFight();
      emit(state.copyWith(error: () => '$e\nAuto fight stopped.'));
    } finally {
      emit(state.copyWith(error: () => null));
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

  Future<void> _autoFight(AutoFightEvent event, Emitter emit) async {
    final String characterName = event.characterName;
    final AutoFightController? autoFightController = _autoFightControllerByName(characterName);
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

    // A negative value indicates that the action has already occurred the specified amount of time ago.
    if (cooldownExpiration.inSeconds < 1) {
      // There is a slight delay before the timer starts. It works stably with a delay of more than 1 second.
      cooldownExpiration = const Duration(seconds: 1);
    }
    autoFightController.setDelay(cooldownExpiration);
    autoFightController.startAutoFight(event.autoFightOnTile);
  }

  Future<void> _actionTaskNew(ActionTaskNewEvent event, Emitter emit) async {
    try {
      final CharacterGameData updatedCharacterGameData =
          await _myCharacterRepository.actionTaskNew(event.characterName);
      _updateCharacters(emit, updatedCharacterGameData);
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(error: () => null));
    }
  }

  Future<void> _actionTaskComplete(ActionTaskCompleteEvent event, Emitter emit) async {
    try {
      final CharacterGameData updatedCharacterGameData =
          await _myCharacterRepository.actionTaskComplete(event.characterName);
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

    final AutoFightController? autoFightController = _autoFightControllerByName(character.name);
    if (autoFightController == null) {
      return;
    }

    if (autoFightController.isAutoFight) {
      // The server returns an incorrect time, we need to wait some more.
      const Duration additionalDelay = Duration(seconds: 1);
      final Duration delayInSeconds = character.cooldownExpiration.difference(DateTime.now()) + additionalDelay;
      autoFightController.setDelay(delayInSeconds);
    }
  }

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

  Future<void> _getGameEvents(GetGameEventsEvent event, Emitter emit) async {
    try {
      final List<GameEvent> gameEvents = await _gameEventsRepository.getAllEvents();
      emit(state.copyWith(gameEvents: gameEvents));
      state.gameEventsController?.setDelay(const Duration(seconds: 60));
    } on EventsNotFoundException {
      emit(state.copyWith(gameEvents: []));
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(error: () => null));
    }
  }
}
