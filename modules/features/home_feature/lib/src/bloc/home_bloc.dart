import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MyCharacterRepository _myCharacterRepository;

  HomeBloc({
    required MyCharacterRepository myCharacterRepository,
  })  : _myCharacterRepository = myCharacterRepository,
        super(HomeState.initial()) {
    on<ChangePositionEvent>(_changePosition);
  }

  Future<void> _changePosition(ChangePositionEvent event, Emitter emit) async {
    await _myCharacterRepository.actionMove(event.characterName, event.position);
  }
}
