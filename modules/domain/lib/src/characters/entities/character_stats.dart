class CharacterStats {
  final int hp;
  final int haste;

  final int attackAir;
  final int attackEarth;
  final int attackFire;
  final int attackWater;

  final int dmgAir;
  final int dmgEarth;
  final int dmgFire;
  final int dmgWater;

  /// In percent
  final int resAir;

  /// In percent
  final int resEarth;

  /// In percent
  final int resFire;

  /// In percent
  final int resWater;

  const CharacterStats({
    required this.hp,
    required this.attackAir,
    required this.attackEarth,
    required this.attackFire,
    required this.attackWater,
    required this.dmgAir,
    required this.dmgEarth,
    required this.dmgFire,
    required this.dmgWater,
    required this.haste,
    required this.resAir,
    required this.resEarth,
    required this.resFire,
    required this.resWater,
  });
}
