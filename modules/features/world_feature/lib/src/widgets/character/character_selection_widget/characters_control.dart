import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../bloc/world_bloc.dart';
import 'character_info.dart';

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
              state.characters.length,
              (int index) {
                final Character character = state.characters[index];

                return Padding(
                  padding: const EdgeInsets.only(right: Dimensions.p16),
                  child: CharacterInfo(
                      character: character,
                      isSelected: state.selectedCharacter?.name == character.name,
                      onPressed: () {
                        context.read<WorldBloc>().add(SelectCharacterEvent(character));
                      }),
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
