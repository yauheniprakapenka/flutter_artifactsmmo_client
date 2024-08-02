class CooldownDto {
  final int totalSeconds;
  final int remainingSeconds;
  final String expiration;
  final String reason;

  const CooldownDto({
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.expiration,
    required this.reason,
  });

  factory CooldownDto.fromJson(Map<String, dynamic> json) {
    return CooldownDto(
      totalSeconds: json['total_seconds'],
      remainingSeconds: json['remaining_seconds'],
      expiration: json['expiration'],
      reason: json['reason'],
    );
  }
}
