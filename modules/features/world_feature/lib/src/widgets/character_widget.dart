import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  final Tile tile;
  final bool isSelected;

  const CharacterWidget({
    required this.tile,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(Dimensions.p8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : AppColors.blackLeatherJacket,
          ),
          child: Text(
            tile.name,
            style: TextStyle(
              color: isSelected ? AppColors.blackLeatherJacket : AppColors.chineseSilver,
              fontSize: 16,
            ),
          ),
        ),
        const AppSpacing.h8(),
        Stack(
          alignment: Alignment.center,
          children: [
            isSelected
                ? SizedBox(
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      child: Image.asset(
                        scale: 1.4,
                        AssetPath.getCharacterAssetPath(tile.skin),
                      ),
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              width: AssetSize.characterSize,
              child: Image.asset(
                AssetPath.getCharacterAssetPath(tile.skin),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
