import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../bloc/world_bloc.dart';
import '../../mapper/tile_content_mapper.dart';
import 'actions/fight_action_widget.dart';
import 'actions/move_action_widget.dart';

class TileDetailsWidget extends StatelessWidget {
  final Tile tile;
  final Character? selectedCharacter;
  final VoidCallback onPressed;

  const TileDetailsWidget({
    required this.tile,
    required this.selectedCharacter,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.6),
        ),
        padding: const EdgeInsets.all(Dimensions.p16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tile.name,
                  style: const TextStyle(color: AppColors.chineseSilver, fontSize: 16),
                ),
                Text(
                  '(${tile.x}, ${tile.y})',
                  style: const TextStyle(color: AppColors.chineseSilver, fontSize: 16),
                ),
              ],
            ),
            const AppSpacing.h16(),
            Text(
              tile.content?.type.name.capitalizeFirstLetter.replaceUnderscoresWithSpaces() ?? '',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const AppSpacing.h8(),
            Text(
              tile.content?.asLocalizeCode ?? '',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
            const AppSpacing.h16(),
            selectedCharacter == null
                ? const SizedBox()
                : Builder(
                    builder: (BuildContext context) {
                      final bool needMove = !(tile.x == selectedCharacter?.x && tile.y == selectedCharacter?.y);
                      if (needMove) {
                        return MoveActionWidget(
                          onPressed: () {
                            context
                                .read<WorldBloc>()
                                .add(ActionMoveEvent(selectedCharacter?.name ?? '', tile));
                          },
                        );
                      }

                      switch (tile.content?.type) {
                        case TileContentType.monster:
                          return FightActionWidget(
                            onPressed: () {
                              context.read<WorldBloc>().add(const ActionFightEvent());
                            },
                          );
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
