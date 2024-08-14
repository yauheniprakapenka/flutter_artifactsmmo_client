/// Character has not completed the task.
class CharacterHasNotCompletedTaskException implements Exception {
  final String message;

  const CharacterHasNotCompletedTaskException(this.message);

  @override
  String toString() => message;
}
