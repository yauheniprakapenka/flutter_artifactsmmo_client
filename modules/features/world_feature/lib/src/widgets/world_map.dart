import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/world_bloc.dart';
import '../utils/world_map_calculator.dart';
import '../utils/world_map_constants.dart';
import 'buttons/zoom_controls.dart';
import 'character/character_image_on_map_widget.dart';
import 'character/character_name_on_map.dart';
import 'tile/tile_widget.dart';
import 'tile_details/tile_details_widget.dart';

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

  double _scale = _minScale;

  static const double _minScale = 1.0;
  static const double _maxScale = 2.0;
  static const double _scaleIncrement = 0.2;
  static const double _initialMapPositionX = 1000.0;
  static const double _initialMapPositionY = 1180.0;

  @override
  void initState() {
    super.initState();
    _initControllers().then((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _initControllers() async {
    _verticalController = ScrollController();
    _horizontalController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        _scale = _animation.value;
        setState(() {});
      });
    await Future.delayed(Duration.zero); // delay zero to make sure the widget is built
    _horizontalController.jumpTo(_initialMapPositionX);
    _verticalController.jumpTo(_initialMapPositionY);
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
          final List<CharacterGameData> characterGameDataList = state.characterGameDataList;

          final List<Character> characters = [];
          for (final CharacterGameData gameData in characterGameDataList) {
            if (gameData.character != null) {
              characters.add(gameData.character!);
            }
          }

          final List<Tile> characterTiles = characters.map((Character character) {
            return character.asTile;
          }).toList();

          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _calculateEdgeScreenPadding(screenSize.width, _scale),
                  vertical: _calculateEdgeScreenPadding(screenSize.height, _scale),
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
                            /// Map tiles

                            ...widget.worldMapCalculator.mapTiles.map((Tile tile) {
                              return Positioned(
                                left: (tile.x - widget.worldMapCalculator.getMinX()) * WorldMapConstants.mapTileSize,
                                top: (tile.y - widget.worldMapCalculator.getMinY()) * WorldMapConstants.mapTileSize,
                                width: WorldMapConstants.mapTileSize,
                                height: WorldMapConstants.mapTileSize,
                                child: TileWidget(
                                  tile: tile,
                                  showGrid: state.showGrid,
                                  onPressed: () {
                                    context.read<WorldBloc>().add(SelectTileEvent(tile));
                                  },
                                ),
                              );
                            }),

                            /// Character images

                            ...groupTilesByPosition(characterTiles).expand((List<Tile> groupedCharacterTiles) {
                              return List.generate(groupedCharacterTiles.length, (int index) {
                                final Tile tile = groupedCharacterTiles[index];
                                final int characterLength = groupedCharacterTiles.length;

                                final List<List<double>> paddingValues = [
                                  [89], // Length 1
                                  [74, 104], // Length 2
                                  [59, 89, 119], // Length 3
                                  [44, 74, 104, 134], // Length 4
                                  [29, 59, 89, 119, 149], // Length 5
                                ];

                                double leftCharacterPadding = 0;
                                if (characterLength > paddingValues.length) {
                                  debugPrint('Unsupported character length: $characterLength');
                                  leftCharacterPadding = 0;
                                } else {
                                  leftCharacterPadding = paddingValues[characterLength - 1][index];
                                }

                                return Positioned(
                                  left: (tile.x - widget.worldMapCalculator.getMinX()) * WorldMapConstants.mapTileSize,
                                  top: (tile.y - widget.worldMapCalculator.getMinY()) * WorldMapConstants.mapTileSize,
                                  width: WorldMapConstants.mapTileSize,
                                  height: WorldMapConstants.mapTileSize,
                                  child: IgnorePointer(
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: leftCharacterPadding,
                                          bottom: 22,
                                          child: CharacterImageOnMapWidget(
                                            tile: tile,
                                            isSelected: state.selectedCharacter?.name == tile.name,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            }),

                            /// Character names

                            ...groupTilesByPosition(characterTiles).expand((List<Tile> groupedCharacterTiles) {
                              return List.generate(groupedCharacterTiles.length, (int index) {
                                final Tile tile = groupedCharacterTiles[index];
                                const double bottomPadding = 54.0;
                                const double spaceBetweenTiles = 2.0;
                                final double nameVerticalPadding = ((CharacterNameOnMapWidget.height + spaceBetweenTiles) * index) + bottomPadding;

                                return Positioned(
                                  left: (tile.x - widget.worldMapCalculator.getMinX()) * WorldMapConstants.mapTileSize,
                                  top: (tile.y - widget.worldMapCalculator.getMinY()) * WorldMapConstants.mapTileSize,
                                  width: WorldMapConstants.mapTileSize,
                                  height: WorldMapConstants.mapTileSize,
                                  child: Padding(
                                    padding: EdgeInsets.zero,
                                    child: IgnorePointer(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: CharacterNameOnMapWidget(
                                          characterName: tile.name,
                                          isSelected: state.selectedCharacter?.name == tile.name,
                                          nameVerticalPadding: nameVerticalPadding,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            }),

                            /// Selected tile

                            state.selectedTile == null
                                ? const SizedBox()
                                : Positioned(
                                    left: (state.selectedTile!.x - widget.worldMapCalculator.getMinX()) * WorldMapConstants.mapTileSize,
                                    top: (state.selectedTile!.y - widget.worldMapCalculator.getMinY()) * WorldMapConstants.mapTileSize,
                                    width: WorldMapConstants.mapTileSize,
                                    height: WorldMapConstants.mapTileSize,
                                    child: TileDetailsWidget(
                                      key: ValueKey(state.selectedCharacter?.cooldownExpiration),
                                      tile: state.selectedTile!,
                                      selectedCharacter: state.selectedCharacter,
                                      onPressed: () {
                                        context.read<WorldBloc>().add(SelectTileEvent(state.selectedTile));
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

    _scale = _minScale;
    final Point<double> characterPosition = _calculateCharacterPosition(character);
    final Point<double> scrollPosition = _calculateScrollPosition(characterPosition, screenSize);
    _animateToPosition(scrollPosition, screenSize);
  }

  Point<double> _calculateCharacterPosition(Character character) {
    final double characterX = (character.asTile.x - widget.worldMapCalculator.getMinX()) * WorldMapConstants.mapTileSize;
    final double characterY = (character.asTile.y - widget.worldMapCalculator.getMinY()) * WorldMapConstants.mapTileSize;
    return Point(characterX, characterY);
  }

  Point<double> _calculateScrollPosition(Point characterPosition, Size screenSize) {
    final double scrollX = characterPosition.x - (screenSize.width / 2) + (WorldMapConstants.mapTileSize / 2);
    final double scrollY = characterPosition.y - (screenSize.height / 2) + (WorldMapConstants.mapTileSize / 2);
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
    _animateScale(_scale + _scaleIncrement);
  }

  void _zoomOut() {
    _animateScale(_scale - _scaleIncrement);
  }

  void _animateScale(double targetScale) {
    _animation = Tween<double>(begin: _scale, end: targetScale.clamp(_minScale, _maxScale)).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward(from: 0);
  }

  double _calculateEdgeScreenPadding(double screenSideSize, double scale) {
    return (screenSideSize * (scale - 1)) / (2 * scale);
  }
}
