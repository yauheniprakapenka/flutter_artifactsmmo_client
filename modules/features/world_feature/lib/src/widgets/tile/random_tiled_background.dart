import 'dart:math';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class RandomTiledBackground extends StatelessWidget {
  final double tileWidth;
  final double tileHeight;
  final List<Widget> stackChildren;

  const RandomTiledBackground({
    required this.tileWidth,
    required this.tileHeight,
    this.stackChildren = const [],
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columnCount = (constraints.maxWidth / tileWidth).ceil();
        final int rowCount = (constraints.maxHeight / tileHeight).ceil();

        return Stack(
          children: [
            ...List.generate(
              rowCount * columnCount,
              (int index) {
                final int row = index ~/ columnCount;
                final int col = index % columnCount;

                return Positioned(
                  left: col * tileWidth,
                  top: row * tileHeight,
                  width: tileWidth,
                  height: tileHeight,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation),
                    child: Image.asset(
                      _background[Random().nextInt(_background.length)],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            ...stackChildren,
          ],
        );
      },
    );
  }
}

final List<String> _background = [
  GameAssets.mapPath('forest_1'),
  GameAssets.mapPath('forest_2'),
  GameAssets.mapPath('forest_3'),
  GameAssets.mapPath('forest_4'),
  GameAssets.mapPath('forest_ashtree1'),
  GameAssets.mapPath('forest_ashtree2'),
  GameAssets.mapPath('forest_birchtree1'),
  GameAssets.mapPath('forest_birchtree2'),
  GameAssets.mapPath('forest_blueslime1'),
  GameAssets.mapPath('forest_blueslime2'),
  GameAssets.mapPath('forest_chicken1'),
  GameAssets.mapPath('forest_coal1'),
  GameAssets.mapPath('forest_copperore1'),
  GameAssets.mapPath('forest_cow1'),
  GameAssets.mapPath('forest_cs1'),
  GameAssets.mapPath('forest_flyingserpent1'),
  GameAssets.mapPath('forest_flyingserpent2'),
  GameAssets.mapPath('forest_gcstation1'),
  GameAssets.mapPath('forest_goldore1'),
  GameAssets.mapPath('forest_grand_exchange1'),
  GameAssets.mapPath('forest_greenslime1'),
  GameAssets.mapPath('forest_greenslime2'),
  GameAssets.mapPath('forest_ironore1'),
  GameAssets.mapPath('forest_jewelrycrafting1'),
  GameAssets.mapPath('forest_miningstation1'),
  GameAssets.mapPath('forest_mushmush1'),
  GameAssets.mapPath('forest_mushmush2'),
  GameAssets.mapPath('forest_pig1'),
  GameAssets.mapPath('forest_sprucetree1'),
  GameAssets.mapPath('forest_sprucetree2'),
  GameAssets.mapPath('forest_village1'),
  GameAssets.mapPath('forest_village2'),
  GameAssets.mapPath('forest_village3'),
  GameAssets.mapPath('forest_village4'),
  GameAssets.mapPath('forest_village5'),
  GameAssets.mapPath('forest_village6'),
  GameAssets.mapPath('forest_wcstation1'),
  GameAssets.mapPath('forest_wolf1'),
  GameAssets.mapPath('forest_wolf2'),
  GameAssets.mapPath('forest_woodcuttingstation1'),
  GameAssets.mapPath('forest_yellowslime1'),
  GameAssets.mapPath('forest_yellowslime2'),
  GameAssets.mapPath('spawn'),
];
