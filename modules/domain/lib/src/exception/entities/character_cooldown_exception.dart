/// Character in cooldown.
class CharacterCooldownException implements Exception {
  final String message;

  const CharacterCooldownException(this.message);

  @override
  String toString() => 'CharacterCooldownException(message: $message)';
}
