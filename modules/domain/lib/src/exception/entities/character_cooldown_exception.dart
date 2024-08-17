import 'app_exception.dart';

/// Character in cooldown.
class CharacterCooldownException implements AppException {
  final String _characterName;
  final String _message;

  @override
  String get message {
    return '$_characterName: $_message';
  }

  const CharacterCooldownException({
    required String characterName,
    required String message,
  })  : _characterName = characterName,
        _message = message;
}
