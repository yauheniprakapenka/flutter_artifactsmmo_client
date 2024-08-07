/// Character is locked. Action is already in progress.
class CharacterLockedException implements Exception {
  final String message;

  const CharacterLockedException(this.message);

  @override
  String toString() => 'CharacterLockedException(message: $message)';
}
