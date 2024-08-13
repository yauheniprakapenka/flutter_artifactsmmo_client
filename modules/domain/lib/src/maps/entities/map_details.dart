import 'tile_content_type.dart';

class MapDetails {
  final List<Tile> tiles;
  final int total;
  final int page;
  final int size;
  final int pages;

  const MapDetails({
    required this.tiles,
    required this.total,
    required this.page,
    required this.size,
    required this.pages,
  });
}

class Tile {
  final String name;
  final String skin;
  final int x;
  final int y;
  final TileContent? content;

  const Tile({
    required this.name,
    required this.skin,
    required this.x,
    required this.y,
    this.content,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tile && other.name == name && other.skin == skin && other.x == x && other.y == y && other.content == content;
  }

  @override
  int get hashCode {
    return name.hashCode ^ skin.hashCode ^ x.hashCode ^ y.hashCode ^ content.hashCode;
  }
}

class TileContent {
  final TileContentType type;
  final String code;

  const TileContent({
    required this.type,
    required this.code,
  });
}

/// Group the `Tile` objects by the same values of `x` and `y`.
List<List<Tile>> groupTilesByPosition(List<Tile> tiles) {
  final List<List<Tile>> groupedTiles = [];

  for (final Tile tile in tiles) {
    bool foundGroup = false;

    for (final List<Tile> group in groupedTiles) {
      if (group.isNotEmpty && group.first.x == tile.x && group.first.y == tile.y) {
        group.add(tile);
        foundGroup = true;
        break;
      }
    }

    if (!foundGroup) {
      groupedTiles.add([tile]);
    }
  }

  return groupedTiles;
}
