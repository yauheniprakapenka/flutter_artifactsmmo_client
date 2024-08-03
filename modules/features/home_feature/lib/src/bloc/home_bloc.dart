import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CharactersRepository _charactersRepository;
  final MyCharacterRepository _myCharacterRepository;

  HomeBloc({
    required CharactersRepository charactersRepository,
    required MyCharacterRepository myCharacterRepository,
  })  : _charactersRepository = charactersRepository,
        _myCharacterRepository = myCharacterRepository,
        super(HomeState.initial()) {
    on<ChangePositionMoveEvent>(_changePositionMove);
    on<ChangePositionXIncrementEvent>(_changePositionXIncrement);
    on<ChangePositionXDecrementEvent>(_changePositionXDecrement);
    on<ChangePositionYIncrementEvent>(_changePositionYIncrement);
    on<ChangePositionYDecrementEvent>(_changePositionYDecrement);
    on<InitialEvent>(_initial);
    add(const InitialEvent());
  }

  Future<void> _initial(InitialEvent event, Emitter emit) async {
    try {
      final List<Character> characters = await _myCharacterRepository.getAllMyCharacters();
      final Character character = characters.first;
      final Point<int> newPosition = Point(character.x, character.y);
      emit(state.copyWith(
        gameData: () => GameData(character: character),
        newPosition: () => newPosition,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false, error: () => null));
    }
  }

  Future<void> _changePositionMove(ChangePositionMoveEvent event, Emitter emit) async {
    final Point<int>? newPosition = state.newPosition;
    if (newPosition == null) {
      return;
    }

    final String? characterName = state.gameData?.character?.name;
    if (characterName == null) {
      return;
    }

    emit(state.copyWith(isChangingPositon: true));

    try {
      final GameData gameData = await _myCharacterRepository.actionMove(
        characterName,
        newPosition,
      );
      emit(state.copyWith(gameData: () => gameData));
    } on Exception catch (e) {
      emit(state.copyWith(error: () => e.toString()));
    } finally {
      emit(state.copyWith(isChangingPositon: false, error: () => null));
    }
  }

  void _changePositionXIncrement(ChangePositionXIncrementEvent event, Emitter emit) {
    _changePosition(emit, 1, 0);
  }

  void _changePositionXDecrement(ChangePositionXDecrementEvent event, Emitter emit) {
    _changePosition(emit, -1, 0);
  }

  void _changePositionYIncrement(ChangePositionYIncrementEvent event, Emitter emit) {
    _changePosition(emit, 0, 1);
  }

  void _changePositionYDecrement(ChangePositionYDecrementEvent event, Emitter emit) {
    _changePosition(emit, 0, -1);
  }

  void _changePosition(Emitter emit, int xDelta, int yDelta) {
    final Point<int>? newPosition = state.newPosition;
    final updatedPosition = newPosition == null
        ? const Point(0, 0)
        : Point(newPosition.x + xDelta, newPosition.y + yDelta);
    emit(state.copyWith(newPosition: () => updatedPosition));
  }
}
