import 'app_exception.dart';

/// Character inventory is full.
class InventoryFullException implements AppException {
  final String _characterName;
  final String _message;

  @override
  String get message {
    return '$_characterName: $_message';
  }

  const InventoryFullException({
    required String characterName,
    required String message,
  })  : _characterName = characterName,
        _message = message;
}
