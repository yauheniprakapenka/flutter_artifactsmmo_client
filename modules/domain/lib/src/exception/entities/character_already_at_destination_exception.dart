import 'app_exception.dart';

/// Character already at destination.
class CharacterAlreadyAtDestinationException implements AppException {
  final String _characterName;
  final String _message;

  @override
  String get message {
    return '$_characterName: $_message';
  }

  const CharacterAlreadyAtDestinationException({
    required String characterName,
    required String message,
  })  : _characterName = characterName,
        _message = message;
}
