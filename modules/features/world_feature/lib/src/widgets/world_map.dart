import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class WorldMap extends StatelessWidget {
  final List<Tile> tiles;

  const WorldMap(this.tiles);

  @override
  Widget build(BuildContext context) {
    // Находим границы карты
    final int minX = tiles.map((Tile t) => t.x).reduce((a, b) => a < b ? a : b);
    final int maxX = tiles.map((Tile t) => t.x).reduce((a, b) => a > b ? a : b);
    final int minY = tiles.map((Tile t) => t.y).reduce((a, b) => a < b ? a : b);
    final int maxY = tiles.map((Tile t) => t.y).reduce((a, b) => a > b ? a : b);

    // Вычисляем размеры всей карты
    final double width = (maxX - minX + 1) * AssetSize.mapTileSize;
    final double height = (maxY - minY + 1) * AssetSize.mapTileSize;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              for (final Tile tile in tiles)
                Positioned(
                  left: (tile.x - minX) * AssetSize.mapTileSize,
                  top: (tile.y - minY) * AssetSize.mapTileSize,
                  width: AssetSize.mapTileSize,
                  height: AssetSize.mapTileSize,
                  child: Image.asset(
                    AssetPath.getMapAssetPath(tile.skin),
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
