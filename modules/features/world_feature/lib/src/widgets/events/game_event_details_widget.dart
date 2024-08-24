import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class GameEventDetailsWidget extends StatelessWidget {
  final GameEvent gameEvent;

  const GameEventDetailsWidget({
    required this.gameEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${gameEvent.name} (${gameEvent.tile.x}, ${gameEvent.tile.y})',
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${gameEvent.expiration.difference(DateTime.now()).inMinutes} mins left',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
