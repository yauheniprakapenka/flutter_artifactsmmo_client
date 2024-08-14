import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../bloc/world_bloc.dart';
import '../../controllers/auto_fight_controller.dart';
import '../../mapper/tile_content_mapper.dart';
import 'actions/action_widget.dart';

class TileDetailsWidget extends StatefulWidget {
  final Tile tile;
  final Character? selectedCharacter;
  final AutoFightController? autoFightController;
  final VoidCallback onPressed;

  const TileDetailsWidget({
    super.key,
    required this.tile,
    required this.selectedCharacter,
    required this.autoFightController,
    required this.onPressed,
  });

  @override
  State<TileDetailsWidget> createState() => _TileDetailsWidgetState();
}

class _TileDetailsWidgetState extends State<TileDetailsWidget> {
  Timer? _timer;
  Duration? _remainingTime;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
    }
    super.dispose();
  }

  void _startTimer() {
    final DateTime? dateTime = widget.selectedCharacter?.cooldownExpiration;
    if (dateTime == null) {
      return;
    }

    setState(() {
      _remainingTime = dateTime.difference(DateTime.now());
    });

    _timer = Timer.periodic(const Duration(milliseconds: 900), (Timer timer) {
      setState(() {
        _remainingTime = dateTime.difference(DateTime.now());
        if (_remainingTime!.inSeconds <= 0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.7),
        ),
        padding: const EdgeInsets.all(Dimensions.p16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.tile.name,
                  style: const TextStyle(color: AppColors.chineseSilver, fontSize: 16),
                ),
                Text(
                  '(${widget.tile.x}, ${widget.tile.y})',
                  style: const TextStyle(color: AppColors.chineseSilver, fontSize: 16),
                ),
              ],
            ),
            const AppSpacing.h16(),
            Text(
              widget.tile.content?.type.name.capitalizeFirstLetter.replaceUnderscoresWithSpaces() ?? '',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const AppSpacing.h8(),
            Text(
              widget.tile.content?.asLocalizeCode ?? '',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Builder(
              builder: (BuildContext context) {
                final Character? character = widget.selectedCharacter;
                if (character == null) {
                  return const SizedBox();
                }

                final TileContent? tileContent = widget.tile.content;
                if (tileContent == null) {
                  return const SizedBox();
                }

                if (_remainingTime == null) {
                  return const SizedBox();
                }

                final AutoFightController? autoFightController = widget.autoFightController;
                if (autoFightController != null) {
                  if (autoFightController.isAutoFight) {
                    final Tile? tile = autoFightController.autoFightOnTile;
                    if (tile != null) {
                      if (tile.x == widget.tile.x && tile.y == widget.tile.y) {
                        return ActionWidget(
                          title: 'Disable auto fight',
                          onPressed: () {
                            context.read<WorldBloc>().add(AutoFightEvent(widget.selectedCharacter!.name, widget.tile));
                          },
                        );
                      }
                    }
                  }
                }

                if (_remainingTime!.inSeconds > 0) {
                  return const SizedBox();
                }

                final bool needMove = !(widget.tile.x == character.x && widget.tile.y == character.y);
                if (needMove) {
                  return ActionWidget.move(
                    onPressed: () {
                      context.read<WorldBloc>().add(ActionMoveEvent(character.name, widget.tile));
                    },
                  );
                }

                switch (tileContent.type) {
                  case TileContentType.monster:
                    return _MonsterWidget(character, widget.tile);
                  case TileContentType.tasks_master:
                    return _TasksMasterWidget(task: character.asCharacterTask, characterName: character.name);
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

class _MonsterWidget extends StatelessWidget {
  final Character character;
  final Tile tile;

  const _MonsterWidget(
    this.character,
    this.tile,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ActionWidget.fight(
          onPressed: () {
            context.read<WorldBloc>().add(ActionFightEvent(character.name));
          },
        ),
        const AppSpacing.w8(),
        ActionWidget(
          title: 'Auto',
          onPressed: () {
            context.read<WorldBloc>().add(AutoFightEvent(character.name, tile));
          },
        ),
      ],
    );
  }
}

class _TasksMasterWidget extends StatelessWidget {
  final String characterName;
  final ChatacterTask task;

  const _TasksMasterWidget({
    required this.characterName,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    if (task.type == TaskContentType.noTask) {
      return ActionWidget.newTask(
        onPressed: () {
          context.read<WorldBloc>().add(ActionTaskNewEvent(characterName));
        },
      );
    }

    if (task.isTaskCompleted) {
      return ActionWidget.completeTask(
        onPressed: () {},
      );
    }

    return const SizedBox();
  }
}
