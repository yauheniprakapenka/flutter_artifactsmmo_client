import 'app_exception.dart';

/// Tasks Master not found on this map.
class TasksMasterNotFoundOnMapException implements AppException {
  @override
  final String message;

  const TasksMasterNotFoundOnMapException(this.message);
}
