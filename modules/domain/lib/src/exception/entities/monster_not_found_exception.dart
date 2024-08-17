import 'app_exception.dart';

/// Monster not found on this map.
class MonsterNotFoundException implements AppException {
  @override
  final String message;

  const MonsterNotFoundException(this.message);
}
