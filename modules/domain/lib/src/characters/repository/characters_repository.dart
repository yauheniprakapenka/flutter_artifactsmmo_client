abstract interface class CharactersRepository {
  const CharactersRepository();

  Future<void> getCharactersByName(String name);
}
