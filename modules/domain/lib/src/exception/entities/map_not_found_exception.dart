import 'app_exception.dart';

/// Map not found.
class MapNotFoundException implements AppException {
  @override
  final String message;

  const MapNotFoundException(this.message);
}
