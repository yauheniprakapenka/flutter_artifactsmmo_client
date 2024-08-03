import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../bloc/home_bloc.dart';
import 'add_character_button.dart';
import 'character_info.dart';

class CharacterSelectionWidget extends StatelessWidget {
  const CharacterSelectionWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
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
                        context.read<HomeBloc>().add(SelectCharacterEvent(character));
                      }),
                );
              },
            ),
            AddCharacterButton(
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}