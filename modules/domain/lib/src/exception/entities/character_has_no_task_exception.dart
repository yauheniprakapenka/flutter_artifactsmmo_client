import 'app_exception.dart';

/// Character has no task.
class CharacterHasNoTaskException implements AppException {
  @override
  final String message;

  const CharacterHasNoTaskException(this.message);
}
