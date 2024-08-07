/// Character inventory is full.
class InventoryFullException implements Exception {
  final String message;

  const InventoryFullException(this.message);

  @override
  String toString() => 'InventoryFullException(message: $message)';
}
