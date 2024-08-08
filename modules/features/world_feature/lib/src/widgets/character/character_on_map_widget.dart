import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CharacterOnMapWidget extends StatelessWidget {
  final Tile tile;
  final bool isSelected;

  const CharacterOnMapWidget({
    required this.tile,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : AppColors.blackLeatherJacket,
          ),
          child: Text(
            tile.name,
            style: TextStyle(
              color: isSelected ? AppColors.blackLeatherJacket : AppColors.chineseSilver,
              fontSize: 12,
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
                        width: AssetSize.characterSize + 3,
                        GameAssets.characterPath(tile.skin),
                      ),
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              width: AssetSize.characterSize,
              child: Image.asset(
                GameAssets.characterPath(tile.skin),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
