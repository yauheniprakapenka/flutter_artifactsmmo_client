import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'skills_tile.dart';

class CharacterSkillsWidget extends StatelessWidget {
  final List<CharacterSkill> skills;

  const CharacterSkillsWidget(
    this.skills,
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
                'SKILLS',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                ).withUpheavalFont,
              ),
              ...List.generate(skills.length, (index) {
                return Column(
                  children: [
                    const AppSpacing.h16(),
                    SkillsTile(skills[index]),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
