class AssetPath {
  static String getMapAssetPath(String skin) {
    return 'assets/images/maps/$skin.png';
  }

  static String getCharacterAssetPath(String skin) {
    return 'assets/images/characters/$skin.png';
  }

  static String getItem(String skin) {
    return 'assets/images/items/$skin.png';
  }

  static String getMonster(String skin) {
    return 'assets/images/monsters/$skin.png';
  }

  static List<String> getAllMapAssetPaths() {
    return _allMapAssetPaths;
  }
}

final List<String> _allMapAssetPaths = [
  AssetPath.getMapAssetPath('forest_1'),
  AssetPath.getMapAssetPath('forest_2'),
  AssetPath.getMapAssetPath('forest_3'),
  AssetPath.getMapAssetPath('forest_4'),
  AssetPath.getMapAssetPath('forest_ashtree1'),
  AssetPath.getMapAssetPath('forest_ashtree2'),
  AssetPath.getMapAssetPath('forest_birchtree1'),
  AssetPath.getMapAssetPath('forest_birchtree2'),
  AssetPath.getMapAssetPath('forest_blueslime1'),
  AssetPath.getMapAssetPath('forest_blueslime2'),
  AssetPath.getMapAssetPath('forest_chicken1'),
  AssetPath.getMapAssetPath('forest_coal1'),
  AssetPath.getMapAssetPath('forest_copperore1'),
  AssetPath.getMapAssetPath('forest_cow1'),
  AssetPath.getMapAssetPath('forest_cs1'),
  AssetPath.getMapAssetPath('forest_flyingserpent1'),
  AssetPath.getMapAssetPath('forest_flyingserpent2'),
  AssetPath.getMapAssetPath('forest_gcstation1'),
  AssetPath.getMapAssetPath('forest_goldore1'),
  AssetPath.getMapAssetPath('forest_grand_exchange1'),
  AssetPath.getMapAssetPath('forest_greenslime1'),
  AssetPath.getMapAssetPath('forest_greenslime2'),
  AssetPath.getMapAssetPath('forest_ironore1'),
  AssetPath.getMapAssetPath('forest_jewelrycrafting1'),
  AssetPath.getMapAssetPath('forest_lake1'),
  AssetPath.getMapAssetPath('forest_lake2'),
  AssetPath.getMapAssetPath('forest_lake3'),
  AssetPath.getMapAssetPath('forest_lake4'),
  AssetPath.getMapAssetPath('forest_miningstation1'),
  AssetPath.getMapAssetPath('forest_mushmush1'),
  AssetPath.getMapAssetPath('forest_mushmush2'),
  AssetPath.getMapAssetPath('forest_ogre1'),
  AssetPath.getMapAssetPath('forest_ogre2'),
  AssetPath.getMapAssetPath('forest_pig1'),
  AssetPath.getMapAssetPath('forest_redslime1'),
  AssetPath.getMapAssetPath('forest_redslime2'),
  AssetPath.getMapAssetPath('forest_skeleton1'),
  AssetPath.getMapAssetPath('forest_skeleton2'),
  AssetPath.getMapAssetPath('forest_skeleton3'),
  AssetPath.getMapAssetPath('forest_skeleton4'),
  AssetPath.getMapAssetPath('forest_skeleton5'),
  AssetPath.getMapAssetPath('forest_skeleton6'),
  AssetPath.getMapAssetPath('forest_skeleton7'),
  AssetPath.getMapAssetPath('forest_skeleton8'),
  AssetPath.getMapAssetPath('forest_skeleton9'),
  AssetPath.getMapAssetPath('forest_sprucetree1'),
  AssetPath.getMapAssetPath('forest_sprucetree2'),
  AssetPath.getMapAssetPath('forest_village1'),
  AssetPath.getMapAssetPath('forest_village2'),
  AssetPath.getMapAssetPath('forest_village3'),
  AssetPath.getMapAssetPath('forest_village4'),
  AssetPath.getMapAssetPath('forest_village5'),
  AssetPath.getMapAssetPath('forest_village6'),
  AssetPath.getMapAssetPath('forest_wcstation1'),
  AssetPath.getMapAssetPath('forest_wolf1'),
  AssetPath.getMapAssetPath('forest_wolf2'),
  AssetPath.getMapAssetPath('forest_woodcuttingstation1'),
  AssetPath.getMapAssetPath('forest_yellowslime1'),
  AssetPath.getMapAssetPath('forest_yellowslime2'),
  AssetPath.getMapAssetPath('spawn'),
];
