class CooldownDto {
  final int totalSeconds;
  final int remainingSeconds;
  final DateTime startedAt;
  final DateTime expiration;
  final String reason;

  const CooldownDto({
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.startedAt,
    required this.expiration,
    required this.reason,
  });

  factory CooldownDto.fromJson(Map<String, dynamic> json) {
    return CooldownDto(
      totalSeconds: json['total_seconds'],
      remainingSeconds: json['remaining_seconds'],
      startedAt: DateTime.parse(json['started_at']),
      expiration: DateTime.parse(json['expiration']),
      reason: json['reason'],
    );
  }
}
