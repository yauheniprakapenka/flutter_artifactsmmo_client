import 'dart:math';
import 'package:flutter/material.dart';

class RandomTiledBackground extends StatelessWidget {
  final List<String> tileAssetPaths;
  final double tileWidth;
  final double tileHeight;
  final List<Widget> stackChildren;

  const RandomTiledBackground({
    required this.tileAssetPaths,
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
                      tileAssetPaths[Random().nextInt(tileAssetPaths.length)],
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
