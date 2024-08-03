class ItemAssets {
  static const String egg = 'assets/images/items/egg.png';
  static const String feather = 'assets/images/items/feather.png';
  static const String golden_egg = 'assets/images/items/golden_egg.png';
  static const String raw_chicken = 'assets/images/items/raw_chicken.png';
  static const String wolf_bone = 'assets/images/items/wolf_bone.png';
  static const String wolf_hair = 'assets/images/items/wolf_hair.png';

  static String assetPathByName(String name) {
    switch (name) {
      case 'egg':
        return ItemAssets.egg;
      case 'feather':
        return ItemAssets.feather;
      case 'golden_egg':
        return ItemAssets.golden_egg;
      case 'raw_chicken':
        return ItemAssets.raw_chicken;
      case 'wolf_bone':
        return ItemAssets.wolf_bone;
      case 'wolf_hair':
        return ItemAssets.wolf_hair;
      default:
        throw Exception('Item not found: $name');
    }
  }
}
