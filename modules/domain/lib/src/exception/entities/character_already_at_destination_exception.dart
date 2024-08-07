/// Character already at destination.
class CharacterAlreadyAtDestinationException implements Exception {
  final String message;

  const CharacterAlreadyAtDestinationException(this.message);

  @override
  String toString() => 'CharacterAlreadyAtDestinationException(message: $message)';
}
