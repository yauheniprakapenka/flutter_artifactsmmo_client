class CharacterNotFoundException implements Exception {
  final String message;

  const CharacterNotFoundException(this.message);

  @override
  String toString() => 'CharacterNotFoundException(message: $message)';
}
