/// Character has no task.
class CharacterHasNoTaskException implements Exception {
  final String message;

  const CharacterHasNoTaskException(this.message);

  @override
  String toString() => message;
}
