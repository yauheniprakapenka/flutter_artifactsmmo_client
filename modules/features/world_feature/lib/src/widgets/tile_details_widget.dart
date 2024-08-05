import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../mapper/tile_content_mapper.dart';

class TileDetailsWidget extends StatelessWidget {
  final Tile tile;
  final VoidCallback onPressed;

  const TileDetailsWidget({
    required this.tile,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.6),
        ),
        padding: const EdgeInsets.all(Dimensions.p16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tile.name,
                  style: const TextStyle(color: AppColors.chineseSilver, fontSize: 16),
                ),
                Text(
                  '(${tile.x}, ${tile.y})',
                  style: const TextStyle(color: AppColors.chineseSilver, fontSize: 16),
                ),
              ],
            ),
            const AppSpacing.h16(),
            Text(
              tile.content?.type.name.capitalizeFirstLetter.replaceUnderscoresWithSpaces() ?? '',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const AppSpacing.h8(),
            Text(
              tile.content?.localizeCode ?? '',
              style: const TextStyle(
                color: AppColors.chineseSilver,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
