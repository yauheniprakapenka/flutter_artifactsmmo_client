import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/world_bloc.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, WorldState>(
      builder: (BuildContext context, WorldState state) {
        final Character? selectedCharacter = state.selectedCharacter;
        if (selectedCharacter == null) {
          return const SizedBox();
        }

        final ChatacterTask task = selectedCharacter.asCharacterTask;
        if (task.type == TaskContentType.noTask) {
          return const SizedBox();
        }

        return Positioned(
          left: Dimensions.edgeInset,
          top: Dimensions.edgeInset,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.p8,
              horizontal: Dimensions.p16,
            ),
            color: AppColors.iluminatingEmerald,
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.target,
                      // ignore: deprecated_member_use
                      color: AppColors.white,
                    ),
                    const AppSpacing.h4(),
                    Text(
                      task.task.replaceUnderscoresWithSpaces(),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${task.leftToComplete} left to kill',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
