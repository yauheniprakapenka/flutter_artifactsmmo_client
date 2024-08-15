import '../../maps/entities/map_details.dart';
import '../../my_characters/entities/inventory_item.dart';
import '../../my_characters/entities/task_content_type.dart';
import 'character_experience.dart';
import 'character_stats.dart';
import 'chatacter_task.dart';

class Character {
  /// `DateTime` in the local time zone.
  final DateTime cooldownExpiration;
  final int attackAir;
  final int attackEarth;
  final int attackFire;
  final int attackWater;
  final int consumable1SlotQuantity;
  final int consumable2SlotQuantity;
  final int cookingLevel;
  final int cookingMaxXp;
  final int cookingXp;
  final int cooldown;
  final int criticalStrike;
  final int dmgAir;
  final int dmgEarth;
  final int dmgFire;
  final int dmgWater;
  final int fishingLevel;
  final int fishingMaxXp;
  final int fishingXp;
  final int gearcraftingLevel;
  final int gearcraftingMaxXp;
  final int gearcraftingXp;
  final int gold;
  final int haste;
  final int hp;
  final int inventoryMaxItems;
  final int jewelrycraftingLevel;
  final int jewelrycraftingMaxXp;
  final int jewelrycraftingXp;
  final int level;
  final int maxXp;
  final int miningLevel;
  final int miningMaxXp;
  final int miningXp;
  final int resAir;
  final int resEarth;
  final int resFire;
  final int resWater;
  final int speed;
  final int stamina;
  final int taskProgress;
  final int taskTotal;
  final int totalXp;
  final int weaponcraftingLevel;
  final int weaponcraftingMaxXp;
  final int weaponcraftingXp;
  final int woodcuttingLevel;
  final int woodcuttingMaxXp;
  final int woodcuttingXp;
  final int x;
  final int xp;
  final int y;
  final List<InventoryItem> inventory;
  final String amuletSlot;
  final String artifact1Slot;
  final String artifact2Slot;
  final String artifact3Slot;
  final String bodyArmorSlot;
  final String bootsSlot;
  final String consumable1Slot;
  final String consumable2Slot;
  final String helmetSlot;
  final String legArmorSlot;
  final String name;
  final String ring1Slot;
  final String ring2Slot;
  final String shieldSlot;
  final String skin;
  final String task;
  final TaskContentType type;
  final String weaponSlot;

  const Character({
    required this.name,
    required this.skin,
    required this.level,
    required this.xp,
    required this.maxXp,
    required this.totalXp,
    required this.gold,
    required this.speed,
    required this.miningLevel,
    required this.miningXp,
    required this.miningMaxXp,
    required this.woodcuttingLevel,
    required this.woodcuttingXp,
    required this.woodcuttingMaxXp,
    required this.fishingLevel,
    required this.fishingXp,
    required this.fishingMaxXp,
    required this.weaponcraftingLevel,
    required this.weaponcraftingXp,
    required this.weaponcraftingMaxXp,
    required this.gearcraftingLevel,
    required this.gearcraftingXp,
    required this.gearcraftingMaxXp,
    required this.jewelrycraftingLevel,
    required this.jewelrycraftingXp,
    required this.jewelrycraftingMaxXp,
    required this.cookingLevel,
    required this.cookingXp,
    required this.cookingMaxXp,
    required this.hp,
    required this.haste,
    required this.criticalStrike,
    required this.stamina,
    required this.attackFire,
    required this.attackEarth,
    required this.attackWater,
    required this.attackAir,
    required this.dmgFire,
    required this.dmgEarth,
    required this.dmgWater,
    required this.dmgAir,
    required this.resFire,
    required this.resEarth,
    required this.resWater,
    required this.resAir,
    required this.x,
    required this.y,
    required this.cooldown,
    required this.cooldownExpiration,
    required this.weaponSlot,
    required this.shieldSlot,
    required this.helmetSlot,
    required this.bodyArmorSlot,
    required this.legArmorSlot,
    required this.bootsSlot,
    required this.ring1Slot,
    required this.ring2Slot,
    required this.amuletSlot,
    required this.artifact1Slot,
    required this.artifact2Slot,
    required this.artifact3Slot,
    required this.consumable1Slot,
    required this.consumable1SlotQuantity,
    required this.consumable2Slot,
    required this.consumable2SlotQuantity,
    required this.task,
    required this.type,
    required this.taskProgress,
    required this.taskTotal,
    required this.inventoryMaxItems,
    required this.inventory,
  });
}

extension CharacterMapper on Character {
  Tile get asTile {
    return Tile(name: name, skin: skin, x: x, y: y);
  }

  CharacterExperience get asCharacterExperience {
    return CharacterExperience(level: level, xp: xp, maxXp: maxXp);
  }

  ChatacterTask get asCharacterTask {
    return ChatacterTask(
      task: task,
      type: type,
      taskProgress: taskProgress,
      taskTotal: taskTotal,
    );
  }

  CharacterStats get asCharacterStats {
    return CharacterStats(
      attackAir: attackAir,
      attackEarth: attackEarth,
      attackFire: attackFire,
      attackWater: attackWater,
      dmgAir: dmgAir,
      dmgEarth: dmgEarth,
      dmgFire: dmgFire,
      dmgWater: dmgWater,
      haste: haste,
      hp: hp,
      resAir: resAir,
      resEarth: resEarth,
      resFire: resFire,
      resWater: resWater,
    );
  }
}
