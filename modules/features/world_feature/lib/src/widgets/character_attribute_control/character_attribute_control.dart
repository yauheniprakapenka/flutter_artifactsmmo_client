import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../bloc/world_bloc.dart';
import '../../models/character_attribute.dart';
import '../buttons/app_text_button.dart';
import 'character_stats_widget.dart';

class CharacterAttributeControl extends StatelessWidget {
  const CharacterAttributeControl();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, WorldState>(builder: (context, state) {
      final Character? selectedCharacter = state.selectedCharacter;

      if (selectedCharacter == null) {
        return const SizedBox();
      }

      return Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 80,
            bottom: Dimensions.edgeInset,
            child: AppTextButton(
              title: 'Stats',
              isSelected: state.selectedCharacterAttribute == CharacterAttribute.stats,
              onPressed: () {
                context.read<WorldBloc>().add(const SelectCharacterAttributeEvent(CharacterAttribute.stats));
              },
            ),
          ),
          state.selectedCharacterAttribute == CharacterAttribute.stats
              ? CharacterStatsWidget(selectedCharacter.asCharacterStats)
              : const SizedBox(),
        ],
      );
    });
  }
}
