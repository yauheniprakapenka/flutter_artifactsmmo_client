import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../bloc/world_bloc.dart';
import '../../cooldown_decorator.dart';
import 'character_button.dart';

class CharactersControl extends StatelessWidget {
  const CharactersControl();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, WorldState>(
      builder: (BuildContext context, WorldState state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppSpacing.h16(),
            ...List.generate(
              state.characterGameDataList.length,
              (int index) {
                final Character? character = state.characterGameDataList[index].character;
                if (character == null) {
                  return const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.only(right: Dimensions.p16),
                  child: CooldownDecorator(
                    lockoutEndTime: character.cooldownExpiration,
                    child: CharacterButton(
                      character: character,
                      isSelected: state.selectedCharacter?.name == character.name,
                      onPressed: () {
                        context.read<WorldBloc>().add(SelectCharacterEvent(character));
                      },
                    ),
                    onPressed: () {
                      context.read<WorldBloc>().add(SelectCharacterEvent(character));
                    },
                  ),
                );
              },
            ),
            // AddCharacterButton(
            //   onPressed: () {},
            // ),
          ],
        );
      },
    );
  }
}
