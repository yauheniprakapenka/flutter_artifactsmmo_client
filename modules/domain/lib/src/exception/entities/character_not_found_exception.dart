import 'app_exception.dart';

class CharacterNotFoundException implements AppException {
  final String _characterName;
  final String _message;

  @override
  String get message {
    return '$_characterName: $_message';
  }

  const CharacterNotFoundException({
    required String characterName,
    required String message,
  })  : _characterName = characterName,
        _message = message;
}
