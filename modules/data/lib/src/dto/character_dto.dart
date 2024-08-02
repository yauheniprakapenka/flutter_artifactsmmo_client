import 'inventory_item_dto.dart';

class CharacterDto {
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
  final List<InventoryItemDto> inventory;
  final String amuletSlot;
  final String artifact1Slot;
  final String artifact2Slot;
  final String artifact3Slot;
  final String bodyArmorSlot;
  final String bootsSlot;
  final String consumable1Slot;
  final String consumable2Slot;
  final String cooldownExpiration;
  final String helmetSlot;
  final String legArmorSlot;
  final String name;
  final String ring1Slot;
  final String ring2Slot;
  final String shieldSlot;
  final String skin;
  final String task;
  final String taskType;
  final String weaponSlot;

  const CharacterDto({
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
    required this.taskType,
    required this.taskProgress,
    required this.taskTotal,
    required this.inventoryMaxItems,
    required this.inventory,
  });

  factory CharacterDto.fromJson(Map<String, dynamic> json) {
    return CharacterDto(
      name: json['name'],
      skin: json['skin'],
      level: json['level'],
      xp: json['xp'],
      maxXp: json['max_xp'],
      totalXp: json['total_xp'],
      gold: json['gold'],
      speed: json['speed'],
      miningLevel: json['mining_level'],
      miningXp: json['mining_xp'],
      miningMaxXp: json['mining_max_xp'],
      woodcuttingLevel: json['woodcutting_level'],
      woodcuttingXp: json['woodcutting_xp'],
      woodcuttingMaxXp: json['woodcutting_max_xp'],
      fishingLevel: json['fishing_level'],
      fishingXp: json['fishing_xp'],
      fishingMaxXp: json['fishing_max_xp'],
      weaponcraftingLevel: json['weaponcrafting_level'],
      weaponcraftingXp: json['weaponcrafting_xp'],
      weaponcraftingMaxXp: json['weaponcrafting_max_xp'],
      gearcraftingLevel: json['gearcrafting_level'],
      gearcraftingXp: json['gearcrafting_xp'],
      gearcraftingMaxXp: json['gearcrafting_max_xp'],
      jewelrycraftingLevel: json['jewelrycrafting_level'],
      jewelrycraftingXp: json['jewelrycrafting_xp'],
      jewelrycraftingMaxXp: json['jewelrycrafting_max_xp'],
      cookingLevel: json['cooking_level'],
      cookingXp: json['cooking_xp'],
      cookingMaxXp: json['cooking_max_xp'],
      hp: json['hp'],
      haste: json['haste'],
      criticalStrike: json['critical_strike'],
      stamina: json['stamina'],
      attackFire: json['attack_fire'],
      attackEarth: json['attack_earth'],
      attackWater: json['attack_water'],
      attackAir: json['attack_air'],
      dmgFire: json['dmg_fire'],
      dmgEarth: json['dmg_earth'],
      dmgWater: json['dmg_water'],
      dmgAir: json['dmg_air'],
      resFire: json['res_fire'],
      resEarth: json['res_earth'],
      resWater: json['res_water'],
      resAir: json['res_air'],
      x: json['x'],
      y: json['y'],
      cooldown: json['cooldown'],
      cooldownExpiration: json['cooldown_expiration'],
      weaponSlot: json['weapon_slot'],
      shieldSlot: json['shield_slot'],
      helmetSlot: json['helmet_slot'],
      bodyArmorSlot: json['body_armor_slot'],
      legArmorSlot: json['leg_armor_slot'],
      bootsSlot: json['boots_slot'],
      ring1Slot: json['ring1_slot'],
      ring2Slot: json['ring2_slot'],
      amuletSlot: json['amulet_slot'],
      artifact1Slot: json['artifact1_slot'],
      artifact2Slot: json['artifact2_slot'],
      artifact3Slot: json['artifact3_slot'],
      consumable1Slot: json['consumable1_slot'],
      consumable1SlotQuantity: json['consumable1_slot_quantity'],
      consumable2Slot: json['consumable2_slot'],
      consumable2SlotQuantity: json['consumable2_slot_quantity'],
      task: json['task'],
      taskType: json['task_type'],
      taskProgress: json['task_progress'],
      taskTotal: json['task_total'],
      inventoryMaxItems: json['inventory_max_items'],
      inventory: List<InventoryItemDto>.from(
        json['inventory'].map((item) => InventoryItemDto.fromJson(item)),
      ),
    );
  }
}
