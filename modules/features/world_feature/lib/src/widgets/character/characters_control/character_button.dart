import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CharacterButton extends StatelessWidget {
  final Character character;
  final bool isSelected;
  final VoidCallback onPressed;

  const CharacterButton({
    required this.character,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 140,
        height: 92,
        padding: const EdgeInsets.all(Dimensions.p8).copyWith(bottom: 0),
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
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            Expanded(
              child: ClipRect(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Image.asset(
                    GameAssets.characterPath(character.skin),
                    scale: isSelected ? 0.9 : 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
