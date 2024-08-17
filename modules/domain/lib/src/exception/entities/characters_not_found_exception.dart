import 'app_exception.dart';

class CharactersNotFoundException implements AppException {
  @override
  final String message;

  const CharactersNotFoundException(
    this.message,
  );
}
