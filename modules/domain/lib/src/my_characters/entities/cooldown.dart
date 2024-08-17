class Cooldown {
  /// `DateTime` in the local time zone.
  final DateTime expiration;
  /// `DateTime` in the local time zone.
  final DateTime startedAt;
  final int remainingSeconds;
  final int totalSeconds;
  final String reason;

  const Cooldown({
    required this.expiration,
    required this.reason,
    required this.remainingSeconds,
    required this.startedAt,
    required this.totalSeconds,
  });

  @override
  String toString() {
    return 'Cooldown(expiration: $expiration, startedAt: $startedAt, remainingSeconds: $remainingSeconds, totalSeconds: $totalSeconds, reason: $reason)';
  }
}
