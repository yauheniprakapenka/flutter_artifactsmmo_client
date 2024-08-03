import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MyCharacterRepository _myCharacterRepository;

  HomeBloc({
    required MyCharacterRepository myCharacterRepository,
  })  : _myCharacterRepository = myCharacterRepository,
        super(HomeState.initial()) {
    on<ChangePositionEvent>(_changePositionMove);
    on<InitialEvent>(_initial);
    on<SelectCharacterEvent>(_selectCharacter);
    add(const InitialEvent());
  }

  Future<void> _initial(InitialEvent event, Emitter emit) async {
    try {
      final List<Character> characters = await _myCharacterRepository.getAllMyCharacters();
      emit(state.copyWith(characters: characters));
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

  void _selectCharacter(SelectCharacterEvent event, Emitter emit) {
    if (state.selectedCharacter?.name == event.character.name) {
      emit(state.copyWith(selectedCharacter: () => null));
      return;
    }
    emit(state.copyWith(selectedCharacter: () => event.character));
  }
}
