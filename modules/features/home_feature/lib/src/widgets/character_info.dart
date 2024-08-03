import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CharacterInfo extends StatelessWidget {
  final Character character;

  const CharacterInfo(this.character);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.p16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius),
        color: AppColors.blackLeatherJacket.withOpacity(0.95),
      ),
      child: Column(
        children: [
          Text(
            character.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.chineseSilver,
            ),
          ),
          const AppSpacing.h8(),
          Image.asset(
            CharacterAvatars.assetPathByName(character.skin),
            scale: 0.8,
          ),
        ],
      ),
    );
  }
}
