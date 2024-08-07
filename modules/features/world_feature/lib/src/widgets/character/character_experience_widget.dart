import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CharacterExperienceWidget extends StatelessWidget {
  final CharacterExperience experience;

  const CharacterExperienceWidget({
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(Dimensions.p12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius),
        color: AppColors.blackLeatherJacket.withOpacity(0.95),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Level ${experience.level}',
                style: const TextStyle(
                  color: AppColors.chineseSilver,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                '${experience.xp}/${experience.maxXp} xp',
                style: const TextStyle(
                  color: AppColors.chineseSilver,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const AppSpacing.h8(),
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            tween: Tween<double>(
              begin: 0,
              end: experience.xp / experience.maxXp,
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
        ],
      ),
    );
  }
}
