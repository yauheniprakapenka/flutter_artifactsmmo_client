import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';

final class WorldMapCalculator {
  final List<Tile> mapTiles;
  int? _minX;
  int? _maxX;
  int? _minY;
  int? _maxY;
  double? _mapWidth;
  double? _mapHeight;

  WorldMapCalculator(this.mapTiles);

  /// Получить минимальное значение карты по оси X.
  int getMinX() {
    if (_minX != null) {
      return _minX!;
    }
    final int minX = mapTiles.map((Tile t) => t.x).reduce((a, b) => a < b ? a : b);
    _minX = minX;
    return minX;
  }

  /// Получить максимальное значение карты по оси X.
  int getMaxX() {
    if (_maxX != null) {
      return _maxX!;
    }
    final int maxX = mapTiles.map((Tile t) => t.x).reduce((a, b) => a > b ? a : b);
    _maxX = maxX;
    return maxX;
  }

  /// Получить минимальное значение карты по оси Y.
  int getMinY() {
    if (_minY != null) {
      return _minY!;
    }
    final int minY = mapTiles.map((Tile t) => t.y).reduce((a, b) => a < b ? a : b);
    _minY = minY;
    return minY;
  }

  /// Получить максимальное значение карты по оси Y.
  int getMaxY() {
    if (_maxY != null) {
      return _maxY!;
    }
    final int maxY = mapTiles.map((Tile t) => t.y).reduce((a, b) => a > b ? a : b);
    _maxY = maxY;
    return maxY;
  }

  /// Получить ширину карты.
  double getMapWidth() {
    if (_mapWidth != null) {
      return _mapWidth!;
    }
    final double mapWidth = (getMaxX() - getMinX() + _one) * AssetSize.mapTileSize;
    _mapWidth = mapWidth;
    return mapWidth;
  }

  /// Получить высоту карты.
  double getMapHeight() {
    if (_mapHeight != null) {
      return _mapHeight!;
    }
    final double mapHeight = _mapHeight = (getMaxY() - getMinY() + _one) * AssetSize.mapTileSize;
    _mapHeight = mapHeight;
    return mapHeight;
  }

  /// Добавление `1` в формуле необходимо, потому что разница между максимальным
  /// и минимальным значением не учитывает сам минимальный тайл.
  ///
  /// Ппример:
  ///
  /// Допустим, есть карта шириной в 3 тайла, с координатами x от 0 до 2.
  /// В этом случае:
  /// minX = 0
  /// maxX = 2
  ///
  /// Если просто вычесть minX из maxX, получим:
  /// maxX - minX = 2 - 0 = 2
  ///
  /// Но на самом деле имеем 3 тайла (0, 1, 2), а не 2.
  ///
  /// Поэтому добавляем 1:
  /// (maxX - minX + 1) = (2 - 0 + 1) = 3
  static const int _one = 1;
}
