class Cooldown {
  final int totalSeconds;
  final int remainingSeconds;
  final DateTime startedAt;
  final DateTime expiration;
  final String reason;

  const Cooldown({
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.startedAt,
    required this.expiration,
    required this.reason,
  });
}
