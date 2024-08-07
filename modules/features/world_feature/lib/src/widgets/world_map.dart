import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/world_bloc.dart';
import '../utils/world_map_calculator.dart';
import '../utils/world_map_constants.dart';
import 'buttons/zoom_controls.dart';
import 'character/character_widget.dart';
import 'tile/tile_details_widget.dart';
import 'tile/tile_widget.dart';

class WorldMap extends StatefulWidget {
  final WorldMapCalculator worldMapCalculator;

  const WorldMap({
    required this.worldMapCalculator,
  });

  @override
  State<WorldMap> createState() => _WorldMapState();
}

class _WorldMapState extends State<WorldMap> with SingleTickerProviderStateMixin {
  late final ScrollController _verticalController;
  late final ScrollController _horizontalController;
  late final AnimationController _animationController;
  late Animation<double> _animation;

  double _scale = WorldMapConstants.minScale;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _verticalController = ScrollController();
    _horizontalController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        _scale = _animation.value;
        setState(() {});
      });
  }

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return BlocListener<WorldBloc, WorldState>(
      listener: (BuildContext context, WorldState state) {
        _focusOnSelectedCharacter(state, screenSize);
      },
      child: BlocBuilder<WorldBloc, WorldState>(
        builder: (BuildContext context, WorldState state) {
          final List<Tile> characterTiles = state.characters.map((Character character) {
            return character.asTile;
          }).toList();

          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _calculatePadding(screenSize.width, _scale),
                  vertical: _calculatePadding(screenSize.height, _scale),
                ),
                child: Transform(
                  transform: Matrix4.identity()..scale(_scale),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
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
                                left: (tile.x - widget.worldMapCalculator.getMinX()) *
                                    AssetSize.mapTileSize,
                                top: (tile.y - widget.worldMapCalculator.getMinY()) *
                                    AssetSize.mapTileSize,
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
                                left: (tile.x - widget.worldMapCalculator.getMinX()) *
                                    AssetSize.mapTileSize,
                                top: (tile.y - widget.worldMapCalculator.getMinY()) *
                                    AssetSize.mapTileSize,
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
                                    left: (state.selectedTile!.x -
                                            widget.worldMapCalculator.getMinX()) *
                                        AssetSize.mapTileSize,
                                    top: (state.selectedTile!.y -
                                            widget.worldMapCalculator.getMinY()) *
                                        AssetSize.mapTileSize,
                                    width: AssetSize.mapTileSize,
                                    height: AssetSize.mapTileSize,
                                    child: TileDetailsWidget(
                                      tile: state.selectedTile!,
                                      onPressed: () {
                                        context
                                            .read<WorldBloc>()
                                            .add(SelectTileEvent(state.selectedTile));
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ZoomControls(
                zoomIn: () => _zoomIn(),
                zoomOut: () => _zoomOut(),
              ),
            ],
          );
        },
      ),
    );
  }

  void _focusOnSelectedCharacter(WorldState state, Size screenSize) {
    if (!state.focusToSelectedCharacter) {
      return;
    }

    final Character? character = state.selectedCharacter;
    if (character == null) {
      return;
    }

    _scale = WorldMapConstants.minScale;
    final Point<double> characterPosition = _calculateCharacterPosition(character);
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

  void _zoomIn() {
    _animateScale(_scale + WorldMapConstants.scaleIncrement);
  }

  void _zoomOut() {
    _animateScale(_scale - WorldMapConstants.scaleIncrement);
  }

  void _animateScale(double targetScale) {
    _animation = Tween<double>(
            begin: _scale,
            end: targetScale.clamp(WorldMapConstants.minScale, WorldMapConstants.maxScale))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward(from: 0);
  }

  double _calculatePadding(double screenSideSize, double scale) {
    return (screenSideSize * (scale - 1)) / (2 * scale);
  }
}
