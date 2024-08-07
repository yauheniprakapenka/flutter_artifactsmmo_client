class Fight {
  final int xp;
  final int gold;
  final List<dynamic> drops;
  final int turns;
  final Map<String, int> monsterBlockedHits;
  final Map<String, int> playerBlockedHits;
  final List<String> logs;
  final String result;

  const Fight({
    required this.xp,
    required this.gold,
    required this.drops,
    required this.turns,
    required this.monsterBlockedHits,
    required this.playerBlockedHits,
    required this.logs,
    required this.result,
  });
}
