import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;
  final bool showGrid;
  final VoidCallback onPressed;

  const TileWidget({
    required this.tile,
    required this.showGrid,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Image.asset(
            GameAssets.mapPath(tile.skin),
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: showGrid ? AppColors.white.withOpacity(0.5) : Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
