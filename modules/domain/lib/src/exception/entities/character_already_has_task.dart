import 'app_exception.dart';

/// Character already has a task.
class CharacterAlreadyHasTask implements AppException {
  final String _characterName;
  final String _message;

  @override
  String get message {
    return '$_characterName: $_message';
  }

  const CharacterAlreadyHasTask({
    required String characterName,
    required String message,
  })  : _characterName = characterName,
        _message = message;
}
