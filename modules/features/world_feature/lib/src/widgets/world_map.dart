import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/world_bloc.dart';
import '../utils/world_map_calculator.dart';
import 'character_widget.dart';
import 'tile_details_widget.dart';
import 'tile_widget.dart';

class WorldMap extends StatefulWidget {
  final WorldMapCalculator worldMapCalculator;

  const WorldMap({
    required this.worldMapCalculator,
  });

  @override
  State<WorldMap> createState() => _WorldMapState();
}

class _WorldMapState extends State<WorldMap> {
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorldBloc, WorldState>(
      listener: (BuildContext context, WorldState state) {
        _focusOnSelectedCharacter(state);
      },
      child: BlocBuilder<WorldBloc, WorldState>(builder: (BuildContext context, WorldState state) {
        final List<Tile> characterTiles = state.characters.map((Character character) {
          return character.asTile;
        }).toList();

        return SingleChildScrollView(
          controller: _horizontalController,
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            controller: _verticalController,
            child: SizedBox(
              width: widget.worldMapCalculator.getMapWidth(),
              height: widget.worldMapCalculator.getMapHeight(),
              child: Stack(
                children: [
                  ...widget.worldMapCalculator.mapTiles.map((Tile tile) {
                    return Positioned(
                      left: (tile.x - widget.worldMapCalculator.getMinX()) * AssetSize.mapTileSize,
                      top: (tile.y - widget.worldMapCalculator.getMinY()) * AssetSize.mapTileSize,
                      width: AssetSize.mapTileSize,
                      height: AssetSize.mapTileSize,
                      child: TileWidget(
                        tile: tile,
                        showGrid: state.showGrid,
                        onPressed: () {
                          context.read<WorldBloc>().add(SelectTileEvent(tile));
                        },
                      ),
                    );
                  }),
                  ...characterTiles.map((Tile tile) {
                    return Positioned(
                      left: (tile.x - widget.worldMapCalculator.getMinX()) * AssetSize.mapTileSize,
                      top: (tile.y - widget.worldMapCalculator.getMinY()) * AssetSize.mapTileSize,
                      width: AssetSize.mapTileSize,
                      height: AssetSize.mapTileSize,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: IgnorePointer(
                              child: CharacterWidget(
                                tile: tile,
                                isSelected: state.selectedCharacter?.name == tile.name,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  state.selectedTile == null
                      ? const SizedBox()
                      : Positioned(
                          left: (state.selectedTile!.x - widget.worldMapCalculator.getMinX()) *
                              AssetSize.mapTileSize,
                          top: (state.selectedTile!.y - widget.worldMapCalculator.getMinY()) *
                              AssetSize.mapTileSize,
                          width: AssetSize.mapTileSize,
                          height: AssetSize.mapTileSize,
                          child: TileDetailsWidget(
                            tile: state.selectedTile!,
                            onPressed: () {
                              context.read<WorldBloc>().add(SelectTileEvent(state.selectedTile));
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _focusOnSelectedCharacter(WorldState state) {
    if (!state.focusToSelectedCharacter) {
      return;
    }

    final Character? character = state.selectedCharacter;
    if (character == null) {
      return;
    }

    final Point<double> characterPosition = _calculateCharacterPosition(character);
    final Size screenSize = MediaQuery.of(context).size;
    final Point<double> scrollPosition = _calculateScrollPosition(characterPosition, screenSize);
    _animateToPosition(scrollPosition, screenSize);
  }

  Point<double> _calculateCharacterPosition(Character character) {
    final double characterX =
        (character.asTile.x - widget.worldMapCalculator.getMinX()) * AssetSize.mapTileSize;
    final double characterY =
        (character.asTile.y - widget.worldMapCalculator.getMinY()) * AssetSize.mapTileSize;
    return Point(characterX, characterY);
  }

  Point<double> _calculateScrollPosition(Point characterPosition, Size screenSize) {
    final double scrollX =
        characterPosition.x - (screenSize.width / 2) + (AssetSize.mapTileSize / 2);
    final double scrollY =
        characterPosition.y - (screenSize.height / 2) + (AssetSize.mapTileSize / 2);
    return Point(scrollX, scrollY);
  }

  void _animateToPosition(Point<double> scrollPosition, Size screenSize) {
    // Ограничиваем значения скролла, чтобы не выйти за пределы карты
    final double maxScrollX = widget.worldMapCalculator.getMapWidth() - screenSize.width;
    final double maxScrollY = widget.worldMapCalculator.getMapHeight() - screenSize.height;

    _horizontalController.animateTo(
      scrollPosition.x.clamp(0, maxScrollX),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    _verticalController.animateTo(
      scrollPosition.y.clamp(0, maxScrollY),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
