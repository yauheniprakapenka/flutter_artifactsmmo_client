import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../mapper/character_skill_mapper.dart';

class SkillsTile extends StatelessWidget {
  final CharacterSkill skill;

  const SkillsTile(
    this.skill,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkJungleGreen,
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      padding: const EdgeInsets.symmetric(vertical: Dimensions.p8, horizontal: Dimensions.p16),
      child: Row(
        children: [
          Image.asset(skill.asAssetPath, width: 36, height: 36),
          const AppSpacing.w16(),
          const AppSpacing.w16(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skill.type.name.capitalizeFirstLetter,
                    style: const TextStyle(
                      color: AppColors.americanSilver,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const AppSpacing.w4(),
                  Text(
                    '(Level ${skill.level}) :',
                    style: const TextStyle(
                      color: AppColors.americanSilver,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const AppSpacing.w4(),
                  Text(
                    '${skill.xp}/${skill.maxXp} xp',
                    style: const TextStyle(
                      color: AppColors.americanSilver,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const AppSpacing.h8(),
              SizedBox(
                width: 320,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  tween: Tween<double>(
                    begin: 0,
                    end: skill.xp / skill.maxXp,
                  ),
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      minHeight: 16,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      backgroundColor: AppColors.chineseSilver,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.iluminatingEmerald),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
