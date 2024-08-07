/// Monster not found on this map.
class MonsterNotFoundException implements Exception {
  final String message;

  const MonsterNotFoundException(this.message);

  @override
  String toString() => 'MonsterNotFoundException(message: $message)';
}
