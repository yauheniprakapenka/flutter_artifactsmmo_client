import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'stats_tile.dart';

class CharacterStatsWidget extends StatelessWidget {
  final CharacterStats stats;

  const CharacterStatsWidget(
    this.stats,
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: 80,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.darkJungleGreen.withOpacity(0.95),
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        child: Container(
          padding: const EdgeInsets.all(Dimensions.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STATS',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                ).withUpheavalFont,
              ),
              const AppSpacing.h16(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatsTile(
                        assetPath: GameAssets.statsPath('hp'),
                        value: stats.hp.toString(),
                        unit: 'HP',
                      ),
                      const AppSpacing.h8(),
                      StatsTile(
                        assetPath: GameAssets.statsPath('haste'),
                        value: stats.haste.toString(),
                        unit: 'Haste',
                      ),
                    ],
                  ),
                  const AppSpacing.w8(),
                  Column(
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
                  ),
                  const AppSpacing.w8(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatsTile(
                        assetPath: GameAssets.statsPath('fire'),
                        value: '${stats.dmgFire}%',
                        unit: 'Fire damage',
                      ),
                      const AppSpacing.h8(),
                      StatsTile(
                        assetPath: GameAssets.statsPath('earth'),
                        value: '${stats.dmgEarth}%',
                        unit: 'Earth damage',
                      ),
                      const AppSpacing.h8(),
                      StatsTile(
                        assetPath: GameAssets.statsPath('water'),
                        value: '${stats.dmgWater}%',
                        unit: 'Water damage',
                      ),
                      const AppSpacing.h8(),
                      StatsTile(
                        assetPath: GameAssets.statsPath('air'),
                        value: '${stats.dmgAir}%',
                        unit: 'Air damage',
                      ),
                    ],
                  ),
                  const AppSpacing.w8(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatsTile(
                        assetPath: GameAssets.statsPath('fire'),
                        value: '${stats.resFire}%',
                        unit: 'Res Fire',
                      ),
                      const AppSpacing.h8(),
                      StatsTile(
                        assetPath: GameAssets.statsPath('earth'),
                        value: '${stats.resEarth}%',
                        unit: 'Res Earth',
                      ),
                      const AppSpacing.h8(),
                      StatsTile(
                        assetPath: GameAssets.statsPath('water'),
                        value: '${stats.resWater}%',
                        unit: 'Res Water',
                      ),
                      const AppSpacing.h8(),
                      StatsTile(
                        assetPath: GameAssets.statsPath('air'),
                        value: '${stats.resAir}%',
                        unit: 'Res Air',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
