import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'stats_tile.dart';

class AttackStatsWidget extends StatelessWidget {
  const AttackStatsWidget({
    super.key,
    required this.stats,
  });

  final CharacterStats stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsTile(
          assetPath: GameAssets.statsPath('air'),
          value: stats.attackAir.toString(),
          unit: 'Air attack',
        ),
        const AppSpacing.h8(),
        StatsTile(
          assetPath: GameAssets.statsPath('earth'),
          value: stats.attackEarth.toString(),
          unit: 'Earth attack',
        ),
        const AppSpacing.h8(),
        StatsTile(
          assetPath: GameAssets.statsPath('fire'),
          value: stats.attackFire.toString(),
          unit: 'Fire attack',
        ),
        const AppSpacing.h8(),
        StatsTile(
          assetPath: GameAssets.statsPath('water'),
          value: stats.attackWater.toString(),
          unit: 'Water attack',
        ),
      ],
    );
  }
}
