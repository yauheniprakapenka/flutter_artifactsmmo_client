/// Character in cooldown.
class CooldownException implements Exception {
  final String message;

  const CooldownException(this.message);

  @override
  String toString() => 'CooldownException(message: $message)';
}
