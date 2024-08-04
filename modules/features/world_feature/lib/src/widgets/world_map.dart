import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'character_widget.dart';

class WorldMap extends StatelessWidget {
  final List<Tile> mapTiles;
  final List<Tile> characterTiles;
  final Character? selectedCharacter;

  const WorldMap({
    required this.mapTiles,
    required this.characterTiles,
    required this.selectedCharacter,
  });

  @override
  Widget build(BuildContext context) {
    // Finding the boundaries of the map
    final int minX = mapTiles.map((Tile t) => t.x).reduce((a, b) => a < b ? a : b);
    final int maxX = mapTiles.map((Tile t) => t.x).reduce((a, b) => a > b ? a : b);
    final int minY = mapTiles.map((Tile t) => t.y).reduce((a, b) => a < b ? a : b);
    final int maxY = mapTiles.map((Tile t) => t.y).reduce((a, b) => a > b ? a : b);

    // Calculating the size of the map
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
              ...mapTiles.map((Tile tile) {
                return Positioned(
                  left: (tile.x - minX) * AssetSize.mapTileSize,
                  top: (tile.y - minY) * AssetSize.mapTileSize,
                  width: AssetSize.mapTileSize,
                  height: AssetSize.mapTileSize,
                  child: Image.asset(
                    AssetPath.getMapAssetPath(tile.skin),
                    fit: BoxFit.cover,
                  ),
                );
              }),
              ...characterTiles.map((Tile tile) {
                return Positioned(
                  left: (tile.x - minX) * AssetSize.mapTileSize,
                  top: (tile.y - minY) * AssetSize.mapTileSize,
                  width: AssetSize.mapTileSize,
                  height: AssetSize.mapTileSize,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CharacterWidget(
                          tile: tile,
                          isSelected: selectedCharacter?.name == tile.name,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
