class Cooldown {
  final int totalSeconds;
  final int remainingSeconds;
  final String expiration;
  final String reason;

  const Cooldown({
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.expiration,
    required this.reason,
  });
}
