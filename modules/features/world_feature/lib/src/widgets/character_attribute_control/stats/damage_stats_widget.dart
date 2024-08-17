import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'stats_tile.dart';

class DamageStatsWidget extends StatelessWidget {
  final CharacterStats stats;

  const DamageStatsWidget({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsTile(
          assetPath: GameAssets.statsPath('air'),
          value: '${stats.dmgAir}%',
          unit: 'Air damage',
        ),
        const AppSpacing.h8(),
        StatsTile(
          assetPath: GameAssets.statsPath('earth'),
          value: '${stats.dmgEarth}%',
          unit: 'Earth damage',
        ),
        const AppSpacing.h8(),
        StatsTile(
          assetPath: GameAssets.statsPath('fire'),
          value: '${stats.dmgFire}%',
          unit: 'Fire damage',
        ),
        const AppSpacing.h8(),
        StatsTile(
          assetPath: GameAssets.statsPath('water'),
          value: '${stats.dmgWater}%',
          unit: 'Water damage',
        ),
      ],
    );
  }
}
