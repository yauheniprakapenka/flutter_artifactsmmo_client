enum CharacterSkillType {
  mining,
  woodcutting,
  fishing,
  weaponcrafting,
  gearcrafting,
  jewelrycrafting,
  cooking,
}

class CharacterSkill {
  final CharacterSkillType type;
  final int level;
  final int maxXp;
  final int xp;

  const CharacterSkill({
    required this.type,
    required this.level,
    required this.maxXp,
    required this.xp,
  });
}
