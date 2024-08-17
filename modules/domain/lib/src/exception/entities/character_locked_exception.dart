import 'app_exception.dart';

/// Character is locked. Action is already in progress.
class CharacterLockedException implements AppException {
  final String _characterName;
  final String _message;

  @override
  String get message {
    return '$_characterName: $_message';
  }

  const CharacterLockedException({
    required String characterName,
    required String message,
  })  : _characterName = characterName,
        _message = message;
}
