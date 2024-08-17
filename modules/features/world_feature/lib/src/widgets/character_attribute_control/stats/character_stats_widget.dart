import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'attack_stats_widget.dart';
import 'damage_stats_widget.dart';
import 'res_stats_widget.dart';
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
              Padding(
                padding: const EdgeInsets.all(Dimensions.p8),
                child: Text(
                  'STATS',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                  ).withUpheavalFont,
                ),
              ),
              const AppSpacing.h16(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppSpacing.w8(),
                  StatsTile(
                    assetPath: GameAssets.statsPath('hp'),
                    value: stats.hp.toString(),
                    unit: 'HP',
                  ),
                  const AppSpacing.w16(),
                  StatsTile(
                    assetPath: GameAssets.statsPath('haste'),
                    value: stats.haste.toString(),
                    unit: 'Haste',
                  ),
                ],
              ),
              const AppSpacing.h8(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppSpacing.w8(),
                  AttackStatsWidget(stats: stats),
                  const AppSpacing.w8(),
                  DamageStatsWidget(stats: stats),
                  const AppSpacing.w8(),
                  ResStatsWidget(stats: stats),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
