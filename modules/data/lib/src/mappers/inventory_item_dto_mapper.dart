import 'package:domain/domain.dart';

import '../dto/inventory_item_dto.dart';

extension InventoryItemDtoMapper on InventoryItemDto {
  InventoryItem get asDomain {
    return InventoryItem(
      slot: slot,
      code: code,
      quantity: quantity,
    );
  }
}
