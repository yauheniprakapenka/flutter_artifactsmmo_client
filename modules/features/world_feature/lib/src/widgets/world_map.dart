import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';
import 'character_widget.dart';

class WorldMap extends StatefulWidget {
  final List<Tile> mapTiles;

  const WorldMap({
    required this.mapTiles,
  });

  @override
  State<WorldMap> createState() => _WorldMapState();
}

class _WorldMapState extends State<WorldMap> {
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  late final int _minX;
  late final int _maxX;
  late final int _minY;
  late final int _maxY;
  late final double _mapWidth;
  late final double _mapHeight;

  @override
  void initState() {
    super.initState();
    _calculateMapDimensions();
  }

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (!state.focusToSelectedCharacter) {
          return;
        }

        final Character? character = state.selectedCharacter;
        if (character == null) {
          return;
        }

        final int characterX = character.asTile.x;
        final int characterY = character.asTile.y;

        // Вычисляем позицию персонажа на карте
        final double characterPositionX = (characterX - _minX) * AssetSize.mapTileSize;
        final double characterPositionY = (characterY - _minY) * AssetSize.mapTileSize;

        // Получаем размеры экрана
        final double screenWidth = MediaQuery.of(context).size.width;
        final double screenHeight = MediaQuery.of(context).size.height;

        // Вычисляем позицию скролла, чтобы персонаж оказался в центре
        final double scrollX = characterPositionX - (screenWidth / 2) + (AssetSize.mapTileSize / 2);
        final double scrollY =
            characterPositionY - (screenHeight / 2) + (AssetSize.mapTileSize / 2);

        // Ограничиваем значения скролла, чтобы не выйти за пределы карты
        final double maxScrollX = _mapWidth - screenWidth;
        final double maxScrollY = _mapHeight - screenHeight;

        _horizontalController.animateTo(
          scrollX.clamp(0, maxScrollX),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        _verticalController.animateTo(
          scrollY.clamp(0, maxScrollY),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: BlocBuilder<HomeBloc, HomeState>(builder: (BuildContext context, HomeState state) {
        final List<Tile> characterTiles = state.characters.map((Character character) {
          return character.asTile;
        }).toList();

        return SingleChildScrollView(
          controller: _horizontalController,
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            controller: _verticalController,
            child: SizedBox(
              width: _mapWidth,
              height: _mapHeight,
              child: Stack(
                children: [
                  ...widget.mapTiles.map((Tile tile) {
                    return Positioned(
                      left: (tile.x - _minX) * AssetSize.mapTileSize,
                      top: (tile.y - _minY) * AssetSize.mapTileSize,
                      width: AssetSize.mapTileSize,
                      height: AssetSize.mapTileSize,
                      child: Image.asset(
                        GameAssets.mapPath(tile.skin),
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                  ...characterTiles.map((Tile tile) {
                    return Positioned(
                      left: (tile.x - _minX) * AssetSize.mapTileSize,
                      top: (tile.y - _minY) * AssetSize.mapTileSize,
                      width: AssetSize.mapTileSize,
                      height: AssetSize.mapTileSize,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: CharacterWidget(
                              tile: tile,
                              isSelected: state.selectedCharacter?.name == tile.name,
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
      }),
    );
  }

  void _calculateMapDimensions() {
    // Finding the boundaries of the map
    _minX = widget.mapTiles.map((Tile t) => t.x).reduce((a, b) => a < b ? a : b);
    _maxX = widget.mapTiles.map((Tile t) => t.x).reduce((a, b) => a > b ? a : b);
    _minY = widget.mapTiles.map((Tile t) => t.y).reduce((a, b) => a < b ? a : b);
    _maxY = widget.mapTiles.map((Tile t) => t.y).reduce((a, b) => a > b ? a : b);

    // Calculating the size of the map
    _mapWidth = (_maxX - _minX + 1) * AssetSize.mapTileSize;
    _mapHeight = (_maxY - _minY + 1) * AssetSize.mapTileSize;
  }
}
