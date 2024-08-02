class InventoryItemDto {
  final int slot;
  final String code;
  final int quantity;

  const InventoryItemDto({
    required this.slot,
    required this.code,
    required this.quantity,
  });

  factory InventoryItemDto.fromJson(Map<String, dynamic> json) {
    return InventoryItemDto(
      slot: json['slot'],
      code: json['code'],
      quantity: json['quantity'],
    );
  }
}
