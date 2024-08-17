import 'app_exception.dart';

/// Character has not completed the task.
class CharacterHasNotCompletedTaskException implements AppException {
  @override
  final String message;

  const CharacterHasNotCompletedTaskException(this.message);
}
