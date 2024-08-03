class MapDetails {
  final List<Tile> data;
  final int total;
  final int page;
  final int size;
  final int pages;

  const MapDetails({
    required this.data,
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
}

class TileContent {
  final String type;
  final String code;

  const TileContent({
    required this.type,
    required this.code,
  });
}
