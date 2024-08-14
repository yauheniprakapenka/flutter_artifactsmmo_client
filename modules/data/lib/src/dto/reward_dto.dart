class RewardDto {
  final String code;
  final int quantity;

  const RewardDto({
    required this.code,
    required this.quantity,
  });

  factory RewardDto.fromJson(Map<String, dynamic> json) {
    return RewardDto(
      code: json['code'],
      quantity: json['quantity'],
    );
  }
}
