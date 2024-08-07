class FightDto {
  final int xp;
  final int gold;
  final List<dynamic> drops;
  final int turns;
  final Map<String, int> monsterBlockedHits;
  final Map<String, int> playerBlockedHits;
  final List<String> logs;
  final String result;

  const FightDto({
    required this.xp,
    required this.gold,
    required this.drops,
    required this.turns,
    required this.monsterBlockedHits,
    required this.playerBlockedHits,
    required this.logs,
    required this.result,
  });

  factory FightDto.fromJson(Map<String, dynamic> json) {
    return FightDto(
      xp: json['xp'],
      gold: json['gold'],
      drops: json['drops'],
      turns: json['turns'],
      monsterBlockedHits: Map<String, int>.from(json['monster_blocked_hits']),
      playerBlockedHits: Map<String, int>.from(json['player_blocked_hits']),
      logs: List<String>.from(json['logs']),
      result: json['result'],
    );
  }
}
