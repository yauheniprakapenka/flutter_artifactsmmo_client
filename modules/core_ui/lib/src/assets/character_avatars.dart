class CharacterAvatars {
  static const String men1 = 'assets/images/characters/men1.png';
  static const String men2 = 'assets/images/characters/men2.png';
  static const String men3 = 'assets/images/characters/men3.png';
  static const String women1 = 'assets/images/characters/women1.png';
  static const String women2 = 'assets/images/characters/women2.png';
  static const String women3 = 'assets/images/characters/women3.png';

  static String assetPathByName(String name) {
    switch (name) {
      case 'men1':
        return CharacterAvatars.men1;
      case 'men2':
        return CharacterAvatars.men2;
      case 'men3':
        return CharacterAvatars.men3;
      case 'women1':
        return CharacterAvatars.women1;
      case 'women2':
        return CharacterAvatars.women2;
      case 'women3':
        return CharacterAvatars.women3;
      default:
        throw ArgumentError('Invalid character name: $name');
    }
  }
}
