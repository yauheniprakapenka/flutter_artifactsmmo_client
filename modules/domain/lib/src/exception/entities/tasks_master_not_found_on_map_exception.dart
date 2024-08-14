/// Tasks Master not found on this map.
class TasksMasterNotFoundOnMapException implements Exception {
  final String message;

  const TasksMasterNotFoundOnMapException(this.message);

  @override
  String toString() => message;
}
