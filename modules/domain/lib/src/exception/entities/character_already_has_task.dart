/// Character already has a task.
class CharacterAlreadyHasTask implements Exception {
  final String message;

  const CharacterAlreadyHasTask(this.message);
}
