import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'stats_tile.dart';

class ResStatsWidget extends StatelessWidget {
  final CharacterStats stats;

  const ResStatsWidget({
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsTile(
          assetPath: GameAssets.statsPath('air'),
          value: '${stats.resAir}%',
          unit: 'Res Air',
        ),
        const AppSpacing.h8(),
        StatsTile(
          assetPath: GameAssets.statsPath('earth'),
          value: '${stats.resEarth}%',
          unit: 'Res Earth',
        ),
        const AppSpacing.h8(),
        StatsTile(
          assetPath: GameAssets.statsPath('fire'),
          value: '${stats.resFire}%',
          unit: 'Res Fire',
        ),
        const AppSpacing.h8(),
        StatsTile(
          assetPath: GameAssets.statsPath('water'),
          value: '${stats.resWater}%',
          unit: 'Res Water',
        ),
      ],
    );
  }
}
