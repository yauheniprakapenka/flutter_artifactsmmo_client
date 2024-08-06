class GameAssets {
  static String mapPath(String skin) {
    return 'assets/images/maps/$skin.png';
  }

  static String characterPath(String skin) {
    return 'assets/images/characters/$skin.png';
  }

  static String itemPath(String skin) {
    return 'assets/images/items/$skin.png';
  }

  static String monsterPath(String skin) {
    return 'assets/images/monsters/$skin.png';
  }

  static String resourcePath(String skin) {
    return 'assets/images/resources/$skin.png';
  }

  static List<String> allMapPaths() {
    return _allMapAssetPaths;
  }
}

final List<String> _allMapAssetPaths = [
  GameAssets.mapPath('forest_1'),
  GameAssets.mapPath('forest_2'),
  GameAssets.mapPath('forest_3'),
  GameAssets.mapPath('forest_4'),
  GameAssets.mapPath('forest_ashtree1'),
  GameAssets.mapPath('forest_ashtree2'),
  GameAssets.mapPath('forest_birchtree1'),
  GameAssets.mapPath('forest_birchtree2'),
  GameAssets.mapPath('forest_blueslime1'),
  GameAssets.mapPath('forest_blueslime2'),
  GameAssets.mapPath('forest_chicken1'),
  GameAssets.mapPath('forest_coal1'),
  GameAssets.mapPath('forest_copperore1'),
  GameAssets.mapPath('forest_cow1'),
  GameAssets.mapPath('forest_cs1'),
  GameAssets.mapPath('forest_flyingserpent1'),
  GameAssets.mapPath('forest_flyingserpent2'),
  GameAssets.mapPath('forest_gcstation1'),
  GameAssets.mapPath('forest_goldore1'),
  GameAssets.mapPath('forest_grand_exchange1'),
  GameAssets.mapPath('forest_greenslime1'),
  GameAssets.mapPath('forest_greenslime2'),
  GameAssets.mapPath('forest_ironore1'),
  GameAssets.mapPath('forest_jewelrycrafting1'),
  GameAssets.mapPath('forest_lake1'),
  GameAssets.mapPath('forest_lake2'),
  GameAssets.mapPath('forest_lake3'),
  GameAssets.mapPath('forest_lake4'),
  GameAssets.mapPath('forest_miningstation1'),
  GameAssets.mapPath('forest_mushmush1'),
  GameAssets.mapPath('forest_mushmush2'),
  GameAssets.mapPath('forest_ogre1'),
  GameAssets.mapPath('forest_ogre2'),
  GameAssets.mapPath('forest_pig1'),
  GameAssets.mapPath('forest_portal'),
  GameAssets.mapPath('forest_redslime1'),
  GameAssets.mapPath('forest_redslime2'),
  GameAssets.mapPath('forest_skeleton1'),
  GameAssets.mapPath('forest_skeleton2'),
  GameAssets.mapPath('forest_skeleton3'),
  GameAssets.mapPath('forest_skeleton4'),
  GameAssets.mapPath('forest_skeleton5'),
  GameAssets.mapPath('forest_skeleton6'),
  GameAssets.mapPath('forest_skeleton7'),
  GameAssets.mapPath('forest_skeleton8'),
  GameAssets.mapPath('forest_skeleton9'),
  GameAssets.mapPath('forest_sprucetree1'),
  GameAssets.mapPath('forest_sprucetree2'),
  GameAssets.mapPath('forest_village1'),
  GameAssets.mapPath('forest_village2'),
  GameAssets.mapPath('forest_village3'),
  GameAssets.mapPath('forest_village4'),
  GameAssets.mapPath('forest_village5'),
  GameAssets.mapPath('forest_village6'),
  GameAssets.mapPath('forest_wcstation1'),
  GameAssets.mapPath('forest_wolf1'),
  GameAssets.mapPath('forest_wolf2'),
  GameAssets.mapPath('forest_woodcuttingstation1'),
  GameAssets.mapPath('forest_yellowslime1'),
  GameAssets.mapPath('forest_yellowslime2'),
  GameAssets.mapPath('spawn'),
];
