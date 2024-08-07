/// Map not found.
class MapNotFoundException implements Exception {
  final String message;

  const MapNotFoundException(this.message);

  @override
  String toString() => message;
}
