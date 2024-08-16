import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';

extension CharacterSkillMapper on CharacterSkill {
  String get asAssetPath {
    switch (type) {
      case CharacterSkillType.mining:
        return GameAssets.skillPath('mining');
      case CharacterSkillType.woodcutting:
        return GameAssets.skillPath('woodcutting');
      case CharacterSkillType.fishing:
        return GameAssets.skillPath('fishing');
      case CharacterSkillType.weaponcrafting:
        return GameAssets.skillPath('weaponcrafting');
      case CharacterSkillType.gearcrafting:
        return GameAssets.skillPath('gearcrafting');
      case CharacterSkillType.jewelrycrafting:
        return GameAssets.skillPath('jewelrycrafting');
      case CharacterSkillType.cooking:
        return GameAssets.skillPath('cooking');
    }
  }
}
