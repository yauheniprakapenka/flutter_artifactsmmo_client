import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CharacterImageOnMapWidget extends StatelessWidget {
  final Tile tile;
  final bool isSelected;

  static const double characterSize = 26.0;

  double get _selectedCharacterSize {
    return characterSize + 3;
  }

  const CharacterImageOnMapWidget({
    required this.tile,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            isSelected
                ? ColorFiltered(
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    child: Image.asset(
                      height: _selectedCharacterSize,
                      width: _selectedCharacterSize,
                      GameAssets.characterPath(tile.skin),
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              width: characterSize,
              height: characterSize,
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
