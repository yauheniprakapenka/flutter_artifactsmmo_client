import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CharacterInfo extends StatelessWidget {
  final Character character;
  final bool isSelected;
  final VoidCallback onPressed;

  const CharacterInfo({
    required this.character,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 140,
        height: 140,
        padding: const EdgeInsets.all(Dimensions.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          color: isSelected
              ? AppColors.iluminatingEmerald
              : AppColors.blackLeatherJacket.withOpacity(0.9),
        ),
        child: Column(
          children: [
            Text(
              character.name,
              style: const TextStyle(
                fontSize: 20,
                color: AppColors.white,
              ),
            ),
            const AppSpacing.h8(),
            Image.asset(
              AssetPath.getCharacterAssetPath(character.skin),
            ),
          ],
        ),
      ),
    );
  }
}
