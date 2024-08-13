import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../bloc/world_bloc.dart';
import '../../mapper/tile_content_mapper.dart';
import 'actions/action_widget.dart';

class TileDetailsWidget extends StatefulWidget {
  final Tile tile;
  final Character? selectedCharacter;
  final bool isAutoFight;
  final VoidCallback onPressed;

  const TileDetailsWidget({
    super.key,
    required this.tile,
    required this.selectedCharacter,
    required this.isAutoFight,
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
            widget.selectedCharacter == null
                ? const SizedBox()
                : Builder(
                    builder: (BuildContext context) {
                      final TileContent? tileContent = widget.tile.content;
                      if (tileContent == null) {
                        return const SizedBox();
                      }

                      final Character? character = widget.selectedCharacter;
                      if (character == null) {
                        return const SizedBox();
                      }

                      if (_remainingTime == null) {
                        return const SizedBox();
                      }

                      if (widget.isAutoFight) {
                        return ActionWidget(
                          title: 'Disable auto fight',
                          onPressed: () {
                            context.read<WorldBloc>().add(AutoFightEvent(widget.selectedCharacter!.name));
                          },
                        );
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
                          return Row(
                            children: [
                              ActionWidget.fight(
                                onPressed: () {
                                  context.read<WorldBloc>().add(ActionFightEvent(widget.selectedCharacter!.name));
                                },
                              ),
                              const AppSpacing.w8(),
                              ActionWidget(
                                title: 'Auto',
                                onPressed: () {
                                  context.read<WorldBloc>().add(AutoFightEvent(widget.selectedCharacter!.name));
                                },
                              ),
                            ],
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
