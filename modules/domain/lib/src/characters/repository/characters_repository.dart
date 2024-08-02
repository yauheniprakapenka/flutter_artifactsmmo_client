import '../entities/character.dart';

abstract interface class CharactersRepository {
  const CharactersRepository();

  /// Retrieve the details of a character.
  Future<Character> getCharactersByName(String name);
}
